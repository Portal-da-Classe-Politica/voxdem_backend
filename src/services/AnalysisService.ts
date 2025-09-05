import { AppDataSource } from '../data-source';
import { Question } from '../entities/Question';

export class AnalysisService {
  
  async getAvailableQuestions() {
    try {
      // Buscar dados sem consultar estrutura por enquanto
      const questionsRaw = await AppDataSource.query(`
        SELECT 
          id,
          code,
          text,
          answer_group_id
        FROM questions 
        WHERE answer_group_id IS NOT NULL 
          AND answer_group_id > 0 
          AND is_active = true
        ORDER BY code
      `);

      // Adicionar contagem de respostas para cada pergunta
      const questionsWithCounts = await Promise.all(
        questionsRaw.map(async (question: any) => {
          const count = await AppDataSource.query(`
            SELECT COUNT(*) as total
            FROM survey_responses sr
            JOIN answers a ON a.survey_response_id = sr.id
            WHERE a.question_id = $1
          `, [question.id]);
          
          return {
            id: question.id,
            code: question.code,
            text: question.text,
            totalResponses: parseInt(count[0]?.total || '0')
          };
        })
      );

      return questionsWithCounts;
    } catch (error) {
      console.error('❌ Erro em getAvailableQuestions:', error);
      throw error;
    }
  }

  async getProfileAttributes() {
    // Buscar atributos de perfil disponíveis na tabela answer_groups
    const profileAttributes = await AppDataSource.query(`
      SELECT DISTINCT 
        CASE 
          WHEN ag.group_name ILIKE '%sexo%' OR ag.group_name ILIKE '%gênero%' THEN 'gender'
          WHEN ag.group_name ILIKE '%idade%' OR ag.group_name ILIKE '%faixa%' THEN 'age_range'
          WHEN ag.group_name ILIKE '%escolaridade%' OR ag.group_name ILIKE '%educação%' THEN 'education'
          WHEN ag.group_name ILIKE '%raça%' OR ag.group_name ILIKE '%cor%' THEN 'race'
          WHEN ag.group_name ILIKE '%região%' THEN 'region'
          WHEN ag.group_name ILIKE '%estado%' OR ag.group_name ILIKE '%uf%' THEN 'state'
          ELSE LOWER(REPLACE(ag.group_name, ' ', '_'))
        END as key,
        ag.group_name as name,
        ag.id as "answerGroupId",
        CASE 
          WHEN ag.group_name ILIKE '%sexo%' OR ag.group_name ILIKE '%gênero%' THEN 'Gênero do respondente'
          WHEN ag.group_name ILIKE '%idade%' OR ag.group_name ILIKE '%faixa%' THEN 'Faixa etária do respondente'
          WHEN ag.group_name ILIKE '%escolaridade%' OR ag.group_name ILIKE '%educação%' THEN 'Nível de escolaridade'
          WHEN ag.group_name ILIKE '%raça%' OR ag.group_name ILIKE '%cor%' THEN 'Raça/cor declarada'
          WHEN ag.group_name ILIKE '%região%' THEN 'Região geográfica'
          WHEN ag.group_name ILIKE '%estado%' OR ag.group_name ILIKE '%uf%' THEN 'Estado (UF)'
          ELSE ag.group_name
        END as description
      FROM answer_groups ag
      WHERE ag.id IN (0, 52, 53, 54, 55, 56)  -- IDs dos grupos de perfil demográfico
        AND ag.id != 0
      ORDER BY key
    `);

    return profileAttributes;
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
          ra.answer_label as label,
          COUNT(*) as count
        FROM response_analysis ra
        WHERE ra.question_code = $1
          AND ra.answer_code NOT IN ('97', '98', '99')  -- Excluir não-respostas
        GROUP BY ra.answer_label
        ORDER BY ra.answer_label
      `, [questionCode]);

      const labels = frequencies.map((f: any) => f.label);
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
          labels,
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
          ra.answer_label as question_answer,
          ra.${profileField} as profile_answer,
          COUNT(*) as count
        FROM response_analysis ra
        WHERE ra.question_code = $1
          AND ra.answer_code NOT IN ('97', '98', '99')
          AND ra.${profileField} IS NOT NULL
        GROUP BY ra.answer_label, ra.${profileField}
        ORDER BY ra.answer_label, ra.${profileField}
      `, [questionCode]);

      // Organizar dados para Chart.js (gráfico de barras agrupadas)
      const questionLabels = [...new Set(crosstabData.map((row: any) => row.question_answer))];
      const profileLabels = [...new Set(crosstabData.map((row: any) => row.profile_answer))];
      
      const datasets = profileLabels.map((profileLabel, index) => {
        const data = questionLabels.map(questionLabel => {
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
          labels: questionLabels,
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
