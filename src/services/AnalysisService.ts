import { AppDataSource } from '../data-source';
import { Question } from '../entities/Question';

export class AnalysisService {
  
  async getSurveys() {
    try {
      const surveys = await AppDataSource.query(`
        SELECT 
          id,
          code,
          description
        FROM surveys
        ORDER BY code
      `);

      return surveys;
    } catch (error) {
      console.error('❌ Erro em getSurveys:', error);
      throw error;
    }
  }

  async getAvailableQuestions(surveyId?: number) {
    try {
      // Buscar perguntas distintas da view response_analysis
      const whereClause = surveyId 
        ? `WHERE question_code IS NOT NULL 
           AND question_text IS NOT NULL
           AND is_active = true
           AND survey_id = $1`
        : `WHERE question_code IS NOT NULL 
           AND question_text IS NOT NULL
           AND is_active = true`;

      const params = surveyId ? [surveyId] : [];

      const questionsRaw = await AppDataSource.query(`
        SELECT DISTINCT 
          question_code as code,
          question_text as text,
          survey_id,
          question_order as question_order,
          COUNT(*) as "totalResponses"
        FROM response_analysis
        ${whereClause}
        GROUP BY question_code, question_text, survey_id, question_order
        ORDER BY question_order
      `, params);

      // Mapear para o formato esperado
      const questionsWithCounts = questionsRaw.map((question: any) => ({
        code: question.code,
        text: question.text,
        surveyId: question.survey_id,
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
          column: 'state_name'
        },
        // NOVOS ATRIBUTOS DE PERFIL
        {
          key: 'religion',
          name: 'Religião',
          description: 'Religião declarada',
          column: 'religion'
        },
        {
          key: 'vote_first_round',
          name: 'Voto 1º Turno',
          description: 'Voto no primeiro turno presidencial 2022',
          column: 'vote_first_round'
        },
        {
          key: 'vote_second_round',
          name: 'Voto 2º Turno',
          description: 'Voto no segundo turno presidencial 2022',
          column: 'vote_second_round'
        },
        {
          key: 'activity_status',
          name: 'Situação de Atividade',
          description: 'Situação de atividade econômica',
          column: 'activity_status'
        },
        {
          key: 'activity_sector',
          name: 'Ramo de Atividade',
          description: 'Setor/ramo de atividade econômica',
          column: 'activity_sector'
        },
        {
          key: 'income_range',
          name: 'Faixa de Renda',
          description: 'Faixa de renda familiar',
          column: 'income_range'
        },
        {
          key: 'political_party',
          name: 'Partido Político',
          description: 'Partido político (Deputados)',
          column: 'political_party'
        }
      ];

      return profileAttributes;
    } catch (error) {
      console.error('❌ Erro em getProfileAttributes:', error);
      throw error;
    }
  }

  async getChartData(questionCode: string, surveyId?: number) {
    try {
      // Buscar pergunta usando SQL direto - construindo query dinamicamente para evitar problema de tipo
      const whereClause = surveyId
        ? `WHERE code = $1 AND is_active = true AND survey_id = ${parseInt(String(surveyId))}`
        : 'WHERE code = $1 AND is_active = true';
      
      const params = [questionCode];

      const questionData = await AppDataSource.query(`
        SELECT id, code, text, answer_group_id, survey_id
        FROM questions 
        ${whereClause}
      `, params);

      if (!questionData || questionData.length === 0) {
        throw new Error(`Pergunta com código ${questionCode} não encontrada`);
      }

      const question = questionData[0];

      // Análise de frequência usando response_analysis
      const freqWhereClause = surveyId
        ? `WHERE ra.question_code = $1 AND ra.survey_id = ${parseInt(String(surveyId))} AND ra.answer_code NOT IN ('97', '98', '99')`
        : 'WHERE ra.question_code = $1 AND ra.answer_code NOT IN (\'97\', \'98\', \'99\')';
      
      const freqParams = [questionCode];

      const frequencies = await AppDataSource.query(`
        SELECT 
          ra.answer_code as code,
          ra.answer_label as label,
          COUNT(*) as count
        FROM response_analysis ra
        ${freqWhereClause}
        GROUP BY ra.answer_code, ra.answer_label
        ORDER BY ra.answer_code::INTEGER
      `, freqParams);

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

  async getChartDataWithProfile(questionCode: string, profileAttribute: string, surveyId?: number) {
    try {
      // Buscar pergunta usando SQL direto  
      let whereClause: string;
      let params: any[];
      
      if (surveyId) {
        // Validar surveyId é número
        const surveyIdInt = parseInt(String(surveyId));
        if (isNaN(surveyIdInt)) {
          throw new Error('surveyId deve ser um número válido');
        }
        whereClause = `WHERE code = $1 AND is_active = true AND survey_id = ${surveyIdInt}`;
        params = [questionCode];
      } else {
        whereClause = 'WHERE code = $1 AND is_active = true';
        params = [questionCode];
      }

      const questionData = await AppDataSource.query(`
        SELECT id, code, text, answer_group_id, survey_id
        FROM questions 
        ${whereClause}
      `, params);

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
        'state': 'state_name',        // UF
        // NOVOS ATRIBUTOS DE PERFIL
        'religion': 'religion',               // RELIGIAO
        'vote_first_round': 'vote_first_round',   // P157
        'vote_second_round': 'vote_second_round',  // P159
        'activity_status': 'activity_status',     // ATIVIDADE_SITUACAO
        'activity_sector': 'activity_sector',     // ATIVIDADE_RAMO
        'income_range': 'income_range',            // RENDA_1
        'political_party': 'political_party'      // PARTIDO (Deputados)
      };

      const profileField = profileMapping[profileAttribute];
      if (!profileField) {
        throw new Error(`Atributo de perfil ${profileAttribute} não encontrado`);
      }

      // Query de cruzamento usando response_analysis
      let crosstabWhereClause: string;
      let crosstabParams: any[];
      
      if (surveyId) {
        const surveyIdInt = parseInt(String(surveyId));
        crosstabWhereClause = `WHERE ra.question_code = $1
           AND ra.survey_id = ${surveyIdInt}
           AND ra.answer_code NOT IN ('97', '98', '99')
           AND ra.${profileField} IS NOT NULL`;
        crosstabParams = [questionCode];
      } else {
        crosstabWhereClause = `WHERE ra.question_code = $1
           AND ra.answer_code NOT IN ('97', '98', '99')
           AND ra.${profileField} IS NOT NULL`;
        crosstabParams = [questionCode];
      }

      const crosstabData = await AppDataSource.query(`
        SELECT 
          ra.answer_code as question_code,
          ra.answer_label as question_answer,
          ra.${profileField} as profile_answer,
          COUNT(*) as count
        FROM response_analysis ra
        ${crosstabWhereClause}
        GROUP BY ra.answer_code, ra.answer_label, ra.${profileField}
        ORDER BY ra.answer_code::INTEGER, ra.${profileField}
      `, crosstabParams);

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
