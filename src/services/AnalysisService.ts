import { AppDataSource } from '../data-source';
import { Question } from '../entities/Question';

export class AnalysisService {
  
  async getAvailableQuestions() {
    try {
      // Buscar perguntas distintas da view response_analysis
      const questionsRaw = await AppDataSource.query(`
        SELECT DISTINCT 
          question_code as code,
          question_text as text,
          question_order as question_order,
          COUNT(*) as "totalResponses"
        FROM response_analysis
        WHERE question_code IS NOT NULL 
          AND question_text IS NOT NULL
          AND is_active = 'true'
        GROUP BY question_code, question_text, question_order
        ORDER BY question_order
      `);

      // Mapear para o formato esperado
      const questionsWithCounts = questionsRaw.map((question: any) => ({
        code: question.code,
        text: question.text,
        totalResponses: parseInt(question.totalResponses || '0')
      }));

      return questionsWithCounts;
    } catch (error) {
      console.error('❌ Erro em getAvailableQuestions:', error);
      throw error;
    }
  }

  async getProfileAttributes() {
    try {
      // Retornar atributos de perfil disponíveis na view response_analysis
      const profileAttributes = [
        {
          key: 'gender',
          name: 'Gênero',
          description: 'Gênero do respondente',
          column: 'gender'
        },
        {
          key: 'age_range',
          name: 'Faixa Etária',
          description: 'Faixa etária do respondente',
          column: 'age_range'
        },
        {
          key: 'education',
          name: 'Escolaridade',
          description: 'Nível de escolaridade',
          column: 'education'
        },
        {
          key: 'race',
          name: 'Raça/Cor',
          description: 'Raça/cor declarada',
          column: 'race'
        },
        {
          key: 'region',
          name: 'Região',
          description: 'Região geográfica',
          column: 'region'
        },
        {
          key: 'state',
          name: 'Estado',
          description: 'Estado (UF)',
          column: 'state'
        }
      ];

      return profileAttributes;
    } catch (error) {
      console.error('❌ Erro em getProfileAttributes:', error);
      throw error;
    }
  }

  async getChartData(questionCode: string) {
    try {
      // Buscar pergunta usando SQL direto para evitar problemas com ORM
      const questionData = await AppDataSource.query(`
        SELECT id, code, text, answer_group_id
        FROM questions 
        WHERE code = $1 AND is_active = true
      `, [questionCode]);

      if (!questionData || questionData.length === 0) {
        throw new Error(`Pergunta com código ${questionCode} não encontrada`);
      }

      const question = questionData[0];

      // Análise de frequência usando response_analysis
      const frequencies = await AppDataSource.query(`
        SELECT 
          ra.answer_code as code,
          ra.answer_label as label,
          COUNT(*) as count
        FROM response_analysis ra
        WHERE ra.question_code = $1
          AND ra.answer_code NOT IN ('97', '98', '99')  -- Excluir não-respostas
        GROUP BY ra.answer_code, ra.answer_label
        ORDER BY ra.answer_code::INTEGER
      `, [questionCode]);

      // Estruturar labels como objetos com código e texto
      const labels = frequencies.map((f: any) => f.label);
      const labelsWithCode = frequencies.map((f: any) => ({
        code: f.code,
        label: f.label,
        //display: `${f.code} - ${f.label}` // Formato combinado para exibição
      }));
      const data = frequencies.map((f: any) => parseInt(f.count));
      
      // Cores padrão para Chart.js
      const backgroundColors = [
        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', 
        '#9966FF', '#FF9F40', '#FF6384', '#C9CBCF',
        '#4BC0C0', '#FF6384', '#36A2EB', '#FFCE56'
      ];

      return {
        question: {
          code: question.code,
          text: question.text
        },
        chartData: {
          labels, // Labels simples para compatibilidade com Chart.js
          labelsDetailed: labelsWithCode, // Labels detalhadas com código
          datasets: [{
            data,
            backgroundColor: backgroundColors.slice(0, data.length),
            borderColor: backgroundColors.slice(0, data.length),
            borderWidth: 1
          }]
        },
        totalResponses: data.reduce((sum: number, count: number) => sum + count, 0)
      };
    } catch (error) {
      console.error('❌ Erro em getChartData:', error);
      throw error;
    }
  }

  async getChartDataWithProfile(questionCode: string, profileAttribute: string) {
    try {
      // Buscar pergunta usando SQL direto
      const questionData = await AppDataSource.query(`
        SELECT id, code, text, answer_group_id
        FROM questions 
        WHERE code = $1 AND is_active = true
      `, [questionCode]);

      if (!questionData || questionData.length === 0) {
        throw new Error(`Pergunta com código ${questionCode} não encontrada`);
      }

      const question = questionData[0];

      // Mapear atributo de perfil para campos da response_analysis
      const profileMapping: { [key: string]: string } = {
        'gender': 'gender',           // SEXO
        'age_range': 'age_range',     // IDADE_FX
        'education': 'education_level', // ESCOLARIDADE
        'race': 'race',               // RACA
        'region': 'region_name',      // REGIAO
        'state': 'state_name'         // UF
      };

      const profileField = profileMapping[profileAttribute];
      if (!profileField) {
        throw new Error(`Atributo de perfil ${profileAttribute} não encontrado`);
      }

      // Query de cruzamento usando response_analysis
      const crosstabData = await AppDataSource.query(`
        SELECT 
          ra.answer_code as question_code,
          ra.answer_label as question_answer,
          ra.${profileField} as profile_answer,
          COUNT(*) as count
        FROM response_analysis ra
        WHERE ra.question_code = $1
          AND ra.answer_code NOT IN ('97', '98', '99')
          AND ra.${profileField} IS NOT NULL
        GROUP BY ra.answer_code, ra.answer_label, ra.${profileField}
        ORDER BY ra.answer_code::INTEGER, ra.${profileField}
      `, [questionCode]);

      // Organizar dados para Chart.js (gráfico de barras agrupadas)
      // Manter a ordem dos dados conforme retornado pela query (já ordenado por answer_code)
      const questionLabelsOrdered: string[] = [];
      const uniqueQuestionData: any[] = [];
      
      // Processar em ordem para manter a sequência do answer_code
      crosstabData.forEach((row: any) => {
        if (!questionLabelsOrdered.includes(row.question_answer)) {
          questionLabelsOrdered.push(row.question_answer);
          uniqueQuestionData.push({
            code: row.question_code,
            label: row.question_answer,
            //display: `${row.question_code} - ${row.question_answer}`
          });
        }
      });
      
      const profileLabels = [...new Set(crosstabData.map((row: any) => row.profile_answer))];
      
      const datasets = profileLabels.map((profileLabel, index) => {
        const data = questionLabelsOrdered.map((questionLabel: string) => {
          const match = crosstabData.find((row: any) => 
            row.question_answer === questionLabel && row.profile_answer === profileLabel
          );
          return match ? parseInt(match.count) : 0;
        });

        // Cores diferentes para cada perfil
        const colors = [
          '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', 
          '#9966FF', '#FF9F40', '#FF6B9D', '#C9CBCF'
        ];

        return {
          label: profileLabel,
          data,
          backgroundColor: colors[index % colors.length],
          borderColor: colors[index % colors.length],
          borderWidth: 1
        };
      });

      return {
        question: {
          code: question.code,
          text: question.text
        },
        profileAttribute,
        chartData: {
          labels: questionLabelsOrdered, // Labels simples para compatibilidade
          labelsDetailed: uniqueQuestionData, // Labels com código
          datasets
        },
        totalResponses: crosstabData.reduce((sum: number, row: any) => sum + parseInt(row.count), 0)
      };
    } catch (error) {
      console.error('❌ Erro em getChartDataWithProfile:', error);
      throw error;
    }
  }
}
