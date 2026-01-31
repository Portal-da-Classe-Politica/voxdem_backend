import request from 'supertest';
import express from 'express';
import chartRoutes from '../../src/routes/chartRoutes';
import { AnalysisService } from '../../src/services/AnalysisService';
import {
  mockSurveys,
  mockQuestions,
  mockProfileAttributes,
  mockChartDataSimple,
  mockChartDataWithProfile,
} from '../mocks/database.mock';

// Mock do AnalysisService
jest.mock('../../src/services/AnalysisService');

describe('Chart Routes', () => {
  let app: express.Application;
  let mockAnalysisService: jest.Mocked<AnalysisService>;

  beforeEach(() => {
    // Criar app Express para testes
    app = express();
    app.use(express.json());
    app.use('/api', chartRoutes);

    // Configurar mocks do AnalysisService
    mockAnalysisService = new AnalysisService() as jest.Mocked<AnalysisService>;
    (AnalysisService as jest.MockedClass<typeof AnalysisService>).mockImplementation(
      () => mockAnalysisService
    );
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('GET /api/surveys', () => {
    it('deve retornar lista de surveys', async () => {
      mockAnalysisService.getSurveys = jest.fn().mockResolvedValue(mockSurveys);

      const response = await request(app).get('/api/surveys');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toEqual(mockSurveys);
      expect(response.body.count).toBe(mockSurveys.length);
      expect(response.body.generatedAt).toBeDefined();
    });

    it('deve retornar erro 500 em caso de falha', async () => {
      mockAnalysisService.getSurveys = jest
        .fn()
        .mockRejectedValue(new Error('Database error'));

      const response = await request(app).get('/api/surveys');

      expect(response.status).toBe(500);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Erro ao buscar surveys');
    });
  });

  describe('GET /api/questions', () => {
    it('deve retornar lista de perguntas sem filtro de survey', async () => {
      mockAnalysisService.getAvailableQuestions = jest
        .fn()
        .mockResolvedValue(mockQuestions);

      const response = await request(app).get('/api/questions');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toEqual(mockQuestions);
      expect(response.body.count).toBe(mockQuestions.length);
      expect(mockAnalysisService.getAvailableQuestions).toHaveBeenCalledWith(undefined);
    });

    it('deve retornar lista de perguntas filtradas por surveyId', async () => {
      const filteredQuestions = mockQuestions.filter((q) => q.surveyId === 2);
      mockAnalysisService.getAvailableQuestions = jest
        .fn()
        .mockResolvedValue(filteredQuestions);

      const response = await request(app).get('/api/questions?surveyId=2');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toEqual(filteredQuestions);
      expect(mockAnalysisService.getAvailableQuestions).toHaveBeenCalledWith(2);
    });

    it('deve retornar erro 500 em caso de falha', async () => {
      mockAnalysisService.getAvailableQuestions = jest
        .fn()
        .mockRejectedValue(new Error('Database error'));

      const response = await request(app).get('/api/questions');

      expect(response.status).toBe(500);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Erro ao buscar perguntas');
    });
  });

  describe('GET /api/profile-attributes', () => {
    it('deve retornar lista de atributos de perfil', async () => {
      mockAnalysisService.getProfileAttributes = jest
        .fn()
        .mockResolvedValue(mockProfileAttributes);

      const response = await request(app).get('/api/profile-attributes');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toEqual(mockProfileAttributes);
      expect(response.body.count).toBe(mockProfileAttributes.length);
    });

    it('deve retornar erro 500 em caso de falha', async () => {
      mockAnalysisService.getProfileAttributes = jest
        .fn()
        .mockRejectedValue(new Error('Database error'));

      const response = await request(app).get('/api/profile-attributes');

      expect(response.status).toBe(500);
      expect(response.body.success).toBe(false);
    });
  });

  describe('GET /api/chart/:questionCode', () => {
    it('deve retornar dados do gráfico para uma pergunta válida', async () => {
      mockAnalysisService.getChartData = jest
        .fn()
        .mockResolvedValue(mockChartDataSimple);

      const response = await request(app).get('/api/chart/P1');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toEqual(mockChartDataSimple);
      expect(mockAnalysisService.getChartData).toHaveBeenCalledWith('P1', undefined);
    });

    it('deve retornar dados do gráfico filtrados por surveyId', async () => {
      mockAnalysisService.getChartData = jest
        .fn()
        .mockResolvedValue(mockChartDataSimple);

      const response = await request(app).get('/api/chart/P1?surveyId=2');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(mockAnalysisService.getChartData).toHaveBeenCalledWith('P1', 2);
    });

    it('deve retornar erro 400 para código de pergunta inválido', async () => {
      const response = await request(app).get('/api/chart/INVALID');

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Código de pergunta inválido');
    });

    it('deve retornar erro 404 para pergunta não encontrada', async () => {
      mockAnalysisService.getChartData = jest
        .fn()
        .mockRejectedValue(new Error('Pergunta com código P999 não encontrada'));

      const response = await request(app).get('/api/chart/P999');

      expect(response.status).toBe(404);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Pergunta não encontrada');
    });

    it('deve retornar erro 500 em caso de falha no servidor', async () => {
      mockAnalysisService.getChartData = jest
        .fn()
        .mockRejectedValue(new Error('Database error'));

      const response = await request(app).get('/api/chart/P1');

      expect(response.status).toBe(500);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Erro ao gerar dados do gráfico');
    });
  });

  describe('GET /api/chart/:questionCode/:profileAttribute', () => {
    it('deve retornar dados do gráfico com cruzamento de perfil', async () => {
      mockAnalysisService.getChartDataWithProfile = jest
        .fn()
        .mockResolvedValue(mockChartDataWithProfile);

      const response = await request(app).get('/api/chart/P1/political_party');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toEqual(mockChartDataWithProfile);
      expect(mockAnalysisService.getChartDataWithProfile).toHaveBeenCalledWith(
        'P1',
        'political_party',
        undefined
      );
    });

    it('deve retornar dados com filtro de surveyId', async () => {
      mockAnalysisService.getChartDataWithProfile = jest
        .fn()
        .mockResolvedValue(mockChartDataWithProfile);

      const response = await request(app).get('/api/chart/P1/political_party?surveyId=2');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(mockAnalysisService.getChartDataWithProfile).toHaveBeenCalledWith(
        'P1',
        'political_party',
        2
      );
    });

    it('deve retornar erro 400 para código de pergunta inválido', async () => {
      const response = await request(app).get('/api/chart/INVALID/political_party');

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Código de pergunta inválido');
    });

    it('deve retornar erro 400 para atributo de perfil inválido', async () => {
      const response = await request(app).get('/api/chart/P1/invalid_attribute');

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Atributo de perfil inválido');
    });

    it('deve retornar erro 404 para pergunta não encontrada', async () => {
      mockAnalysisService.getChartDataWithProfile = jest
        .fn()
        .mockRejectedValue(new Error('Pergunta com código P999 não encontrada'));

      const response = await request(app).get('/api/chart/P999/political_party');

      expect(response.status).toBe(404);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Recurso não encontrado');
    });

    it('deve retornar erro 500 em caso de falha no servidor', async () => {
      mockAnalysisService.getChartDataWithProfile = jest
        .fn()
        .mockRejectedValue(new Error('Database error'));

      const response = await request(app).get('/api/chart/P1/political_party');

      expect(response.status).toBe(500);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Erro ao gerar dados do gráfico com perfil');
    });
  });
});
