import { AnalysisService } from '../../src/services/AnalysisService';
import { AppDataSource } from '../../src/data-source';

// Mock do AppDataSource
jest.mock('../../src/data-source', () => ({
  AppDataSource: {
    query: jest.fn(),
  },
}));

describe('AnalysisService', () => {
  let service: AnalysisService;

  beforeEach(() => {
    service = new AnalysisService();
    jest.clearAllMocks();
  });

  describe('getSurveys', () => {
    it('deve retornar lista de surveys', async () => {
      const mockSurveys = [
        { id: 1, code: 'VOXDEM', description: 'Pesquisa Voxdem' },
        { id: 2, code: 'DEPUTADOS', description: 'Pesquisa Deputados' },
      ];

      (AppDataSource.query as jest.Mock).mockResolvedValue(mockSurveys);

      const result = await service.getSurveys();

      expect(result).toEqual(mockSurveys);
      expect(AppDataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('SELECT')
      );
    });

    it('deve propagar erro em caso de falha', async () => {
      (AppDataSource.query as jest.Mock).mockRejectedValue(
        new Error('Database error')
      );

      await expect(service.getSurveys()).rejects.toThrow('Database error');
    });
  });

  describe('getAvailableQuestions', () => {
    it('deve retornar perguntas sem filtro de survey', async () => {
      const mockQuestions = [
        {
          code: 'P1',
          text: 'Pergunta 1',
          survey_id: 2,
          question_order: 1,
          totalResponses: '100',
        },
      ];

      (AppDataSource.query as jest.Mock).mockResolvedValue(mockQuestions);

      const result = await service.getAvailableQuestions();

      expect(result).toHaveLength(1);
      expect(result[0].code).toBe('P1');
      expect(result[0].totalResponses).toBe(100);
      expect(AppDataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('FROM response_analysis'),
        []
      );
    });

    it('deve retornar perguntas filtradas por surveyId', async () => {
      const mockQuestions = [
        {
          code: 'P1',
          text: 'Pergunta 1',
          survey_id: 2,
          question_order: 1,
          totalResponses: '100',
        },
      ];

      (AppDataSource.query as jest.Mock).mockResolvedValue(mockQuestions);

      const result = await service.getAvailableQuestions(2);

      expect(result).toHaveLength(1);
      expect(result[0].surveyId).toBe(2);
      expect(AppDataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('survey_id = $1'),
        [2]
      );
    });
  });

  describe('getProfileAttributes', () => {
    it('deve retornar lista de atributos de perfil', async () => {
      const result = await service.getProfileAttributes();

      expect(result).toBeInstanceOf(Array);
      expect(result.length).toBeGreaterThan(0);
      expect(result[0]).toHaveProperty('key');
      expect(result[0]).toHaveProperty('name');
      expect(result[0]).toHaveProperty('description');
      expect(result[0]).toHaveProperty('column');
      
      // Verificar atributos específicos
      const genderAttr = result.find(attr => attr.key === 'gender');
      expect(genderAttr).toBeDefined();
      expect(genderAttr?.name).toBe('Gênero');
      
      const partyAttr = result.find(attr => attr.key === 'political_party');
      expect(partyAttr).toBeDefined();
      expect(partyAttr?.name).toBe('Partido Político');
    });
  });

  describe('getChartData', () => {
    it('deve retornar dados de gráfico para uma pergunta', async () => {
      const mockQuestionData = [
        {
          id: 2000,
          code: 'P1',
          text: 'Satisfação com a democracia',
          answer_group_id: 100,
          survey_id: 2,
        },
      ];

      const mockFrequencies = [
        { code: '1', label: 'Muito satisfeito', count: '50' },
        { code: '2', label: 'Satisfeito', count: '100' },
        { code: '3', label: 'Pouco satisfeito', count: '150' },
      ];

      (AppDataSource.query as jest.Mock)
        .mockResolvedValueOnce(mockQuestionData)
        .mockResolvedValueOnce(mockFrequencies);

      const result = await service.getChartData('P1', 2);

      expect(result).toHaveProperty('question');
      expect(result.question.code).toBe('P1');
      expect(result).toHaveProperty('chartData');
      expect(result.chartData.labels).toHaveLength(3);
      expect(result.chartData.datasets).toHaveLength(1);
      expect(result.totalResponses).toBe(300);
    });

    it('deve lançar erro se pergunta não for encontrada', async () => {
      (AppDataSource.query as jest.Mock).mockResolvedValue([]);

      await expect(service.getChartData('P999', 2)).rejects.toThrow(
        'Pergunta com código P999 não encontrada'
      );
    });

    it('deve filtrar respostas com códigos 97, 98, 99', async () => {
      const mockQuestionData = [
        {
          id: 2000,
          code: 'P1',
          text: 'Satisfação com a democracia',
          answer_group_id: 100,
          survey_id: 2,
        },
      ];

      const mockFrequencies = [
        { code: '1', label: 'Resposta válida', count: '50' },
      ];

      (AppDataSource.query as jest.Mock)
        .mockResolvedValueOnce(mockQuestionData)
        .mockResolvedValueOnce(mockFrequencies);

      await service.getChartData('P1', 2);

      expect(AppDataSource.query).toHaveBeenCalledWith(
        expect.stringContaining("NOT IN ('97', '98', '99')"),
        expect.any(Array)
      );
    });
  });

  describe('getChartDataWithProfile', () => {
    it('deve retornar dados de gráfico com cruzamento de perfil', async () => {
      const mockQuestionData = [
        {
          id: 2000,
          code: 'P1',
          text: 'Satisfação com a democracia',
          answer_group_id: 100,
          survey_id: 2,
        },
      ];

      const mockCrosstab = [
        { answer_code: '1', answer_label: 'Sim', profile_value: 'PT', count: '30' },
        { answer_code: '1', answer_label: 'Sim', profile_value: 'PL', count: '20' },
        { answer_code: '2', answer_label: 'Não', profile_value: 'PT', count: '40' },
        { answer_code: '2', answer_label: 'Não', profile_value: 'PL', count: '50' },
      ];

      (AppDataSource.query as jest.Mock)
        .mockResolvedValueOnce(mockQuestionData)
        .mockResolvedValueOnce(mockCrosstab);

      const result = await service.getChartDataWithProfile('P1', 'political_party', 2);

      expect(result).toHaveProperty('question');
      expect(result.question.code).toBe('P1');
      expect(result).toHaveProperty('profileAttribute');
      expect(result.profileAttribute).toBeDefined();
      expect(result).toHaveProperty('chartData');
      expect(result.chartData.datasets.length).toBeGreaterThan(0);
    });

    it('deve lançar erro para atributo de perfil inválido', async () => {
      await expect(
        service.getChartDataWithProfile('P1', 'invalid_attribute', 2)
      ).rejects.toThrow('Atributo de perfil invalid_attribute não encontrado');
    });

    it('deve validar surveyId numérico', async () => {
      await expect(
        service.getChartDataWithProfile('P1', 'political_party', NaN)
      ).rejects.toThrow('surveyId deve ser um número válido');
    });
  });
});
