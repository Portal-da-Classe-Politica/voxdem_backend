import request from 'supertest';
import express from 'express';
import chartRoutes from '../../src/routes/chartRoutes';
import { AnalysisService } from '../../src/services/AnalysisService';

// Mock do AnalysisService
jest.mock('../../src/services/AnalysisService');

/**
 * Testes para TODAS as perguntas da pesquisa de deputados
 * Garante que cada pergunta pode ser consultada e retorna dados válidos
 */
describe('Deputados Questions - Testes de Integração', () => {
  let app: express.Application;
  let mockAnalysisService: jest.Mocked<AnalysisService>;

  // Lista completa de todas as perguntas da pesquisa de deputados
  const deputadosQuestions = [
    { code: 'P1', text: 'Satisfação com a democracia', answerGroup: 100 },
    { code: 'P3_1', text: 'Que as eleições nacionais sejam livres e justas.', answerGroup: 101 },
    { code: 'P3_2', text: 'Que os eleitores discutam política com pessoas que conhecem antes de decidir como votar.', answerGroup: 101 },
    { code: 'P3_3', text: 'Que os partidos de oposição sejam livres para criticar o governo.', answerGroup: 101 },
    { code: 'P3_4', text: 'Que a mídia seja livre para criticar o governo.', answerGroup: 101 },
    { code: 'P3_5', text: 'Que os direitos de grupos minoritários sejam protegidos.', answerGroup: 101 },
    { code: 'P3_6', text: 'Que os cidadãos tenham a palavra final sobre as questões políticas mais importantes, votando diretamente em plebiscitos e referendos.', answerGroup: 101 },
    { code: 'P3_7', text: 'Que os tribunais tratem todos da mesma forma.', answerGroup: 101 },
    { code: 'P3_8', text: 'Que os tribunais sejam capazes de impedir o governo de agir além de sua autoridade, praticando ilegalidades.', answerGroup: 101 },
    { code: 'P3_9', text: 'Que os partidos governistas sejam punidos nas eleições quando fizeram um trabalho ruim.', answerGroup: 101 },
    { code: 'P3_10', text: 'Que o governo proteja todos os cidadãos contra a pobreza.', answerGroup: 101 },
    { code: 'P3_11', text: 'Que o governo reduza as diferenças de renda e riqueza.', answerGroup: 101 },
    { code: 'P4', text: 'Autoposicionamento Ideológico', answerGroup: 109 },
    { code: 'P5_1', text: 'O Estado brasileiro, em vez do setor privado, deveria ser dono das empresas e indústrias mais importantes do país.', answerGroup: 102 },
    { code: 'P5_2', text: 'A decisão sobre fazer ou não um aborto deve ser tomado exclusivamente pela mulher.', answerGroup: 102 },
    { code: 'P5_3', text: 'Redução da maioridade penal.', answerGroup: 102 },
    { code: 'P5_4', text: 'Desenvolvimento econômico e criação de empregos deveriam ser prioritários, mesmo que o meio ambiente sofra algum dano.', answerGroup: 102 },
    { code: 'P5_5', text: 'Os humanos foram feitos para governar a natureza.', answerGroup: 102 },
    { code: 'P5_6', text: 'Os brancos no Brasil têm certas vantagens por causa da cor da pele.', answerGroup: 102 },
    { code: 'P5_7', text: 'Devemos respeitar os resultados das eleições, não importa qual candidato vença.', answerGroup: 102 },
    { code: 'P5_8', text: 'O STF brasileiro deve ser capaz de anular as decisões do presidente e as políticas que forem consideradas ilegais.', answerGroup: 102 },
    { code: 'P5_9', text: 'O presidente deve poder ignorar as decisões judiciais consideradas politicamente tendenciosas.', answerGroup: 102 },
    { code: 'P5_10', text: 'Que a minoria aceite a vontade da maioria em todas as circunstâncias.', answerGroup: 102 },
    { code: 'P6_1', text: 'Em primeiro lugar?', answerGroup: 143 },
    { code: 'P6_2', text: 'Em segundo lugar?', answerGroup: 143 },
  ];

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

  describe('Teste individual de cada pergunta', () => {
    // Criar um teste para cada pergunta dinamicamente
    deputadosQuestions.forEach((question) => {
      it(`deve retornar dados para pergunta ${question.code}: ${question.text.substring(0, 50)}...`, async () => {
        // Mock de resposta para esta pergunta
        const mockResponse = {
          question: {
            code: question.code,
            text: question.text,
          },
          chartData: {
            labels: ['Resposta 1', 'Resposta 2', 'Resposta 3'],
            labelsDetailed: [
              { code: '1', label: 'Resposta 1' },
              { code: '2', label: 'Resposta 2' },
              { code: '3', label: 'Resposta 3' },
            ],
            datasets: [
              {
                data: [100, 200, 213],
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
                borderColor: ['#FF6384', '#36A2EB', '#FFCE56'],
                borderWidth: 1,
              },
            ],
          },
          totalResponses: 513,
        };

        mockAnalysisService.getChartData = jest.fn().mockResolvedValue(mockResponse);

        const response = await request(app).get(`/api/chart/${question.code}?surveyId=2`);

        expect(response.status).toBe(200);
        expect(response.body.success).toBe(true);
        expect(response.body.data).toBeDefined();
        expect(response.body.data.question.code).toBe(question.code);
        expect(response.body.data.chartData).toBeDefined();
        expect(response.body.data.chartData.labels).toBeDefined();
        expect(response.body.data.chartData.datasets).toBeDefined();
        expect(response.body.data.totalResponses).toBeGreaterThanOrEqual(0);
        expect(mockAnalysisService.getChartData).toHaveBeenCalledWith(question.code, 2);
      });
    });
  });

  describe('Teste de cruzamento com perfil político para perguntas selecionadas', () => {
    // Testar algumas perguntas chave com cruzamento de perfil
    const keyQuestions = ['P1', 'P4', 'P5_1', 'P5_2', 'P5_7'];

    keyQuestions.forEach((questionCode) => {
      it(`deve retornar dados cruzados por partido político para ${questionCode}`, async () => {
        const question = deputadosQuestions.find((q) => q.code === questionCode);
        
        const mockResponse = {
          question: {
            code: questionCode,
            text: question?.text || '',
          },
          profileAttribute: {
            key: 'political_party',
            name: 'Partido Político',
          },
          chartData: {
            labels: ['Resposta 1', 'Resposta 2', 'Resposta 3'],
            labelsDetailed: [
              { code: '1', label: 'Resposta 1' },
              { code: '2', label: 'Resposta 2' },
              { code: '3', label: 'Resposta 3' },
            ],
            datasets: [
              {
                label: 'PT',
                data: [30, 50, 20],
                backgroundColor: '#FF6384',
              },
              {
                label: 'PL',
                data: [20, 40, 40],
                backgroundColor: '#36A2EB',
              },
            ],
          },
          profileValues: ['PT', 'PL'],
          totalResponses: 200,
        };

        mockAnalysisService.getChartDataWithProfile = jest
          .fn()
          .mockResolvedValue(mockResponse);

        const response = await request(app).get(
          `/api/chart/${questionCode}/political_party?surveyId=2`
        );

        expect(response.status).toBe(200);
        expect(response.body.success).toBe(true);
        expect(response.body.data).toBeDefined();
        expect(response.body.data.question.code).toBe(questionCode);
        expect(response.body.data.profileAttribute).toBeDefined();
        expect(response.body.data.chartData.datasets).toBeDefined();
        expect(response.body.data.chartData.datasets.length).toBeGreaterThan(0);
        expect(mockAnalysisService.getChartDataWithProfile).toHaveBeenCalledWith(
          questionCode,
          'political_party',
          2
        );
      });
    });
  });

  describe('Validação de formato de resposta para todas as perguntas', () => {
    it('deve validar estrutura de resposta para todas as perguntas', async () => {
      for (const question of deputadosQuestions) {
        const mockResponse = {
          question: {
            code: question.code,
            text: question.text,
          },
          chartData: {
            labels: ['A', 'B'],
            labelsDetailed: [
              { code: '1', label: 'A' },
              { code: '2', label: 'B' },
            ],
            datasets: [
              {
                data: [50, 50],
                backgroundColor: ['#FF6384', '#36A2EB'],
                borderColor: ['#FF6384', '#36A2EB'],
                borderWidth: 1,
              },
            ],
          },
          totalResponses: 100,
        };

        mockAnalysisService.getChartData = jest.fn().mockResolvedValue(mockResponse);

        const response = await request(app).get(`/api/chart/${question.code}?surveyId=2`);

        // Validar estrutura obrigatória
        expect(response.body.data.question).toBeDefined();
        expect(response.body.data.question.code).toBe(question.code);
        expect(response.body.data.question.text).toBeDefined();
        expect(response.body.data.chartData).toBeDefined();
        expect(response.body.data.chartData.labels).toBeInstanceOf(Array);
        expect(response.body.data.chartData.datasets).toBeInstanceOf(Array);
        expect(response.body.data.chartData.datasets[0]).toBeDefined();
        expect(response.body.data.chartData.datasets[0].data).toBeInstanceOf(Array);
        expect(response.body.data.totalResponses).toBeGreaterThanOrEqual(0);
      }
    });
  });

  describe('Teste de validação de códigos', () => {
    it('deve aceitar todos os códigos de perguntas de deputados como válidos', async () => {
      // Regex de validação da rota: /^P[0-9]+(_[0-9]+)?[A-Z]*$/i
      const validationRegex = /^P[0-9]+(_[0-9]+)?[A-Z]*$/i;

      deputadosQuestions.forEach((question) => {
        expect(question.code).toMatch(validationRegex);
      });
    });
  });

  describe('Teste de erro para perguntas inexistentes', () => {
    it('deve retornar 404 para pergunta inexistente no survey de deputados', async () => {
      mockAnalysisService.getChartData = jest
        .fn()
        .mockRejectedValue(new Error('Pergunta com código P999 não encontrada'));

      const response = await request(app).get('/api/chart/P999?surveyId=2');

      expect(response.status).toBe(404);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toBe('Pergunta não encontrada');
    });
  });

  describe('Teste de listagem de perguntas', () => {
    it('deve listar todas as perguntas do survey de deputados', async () => {
      const mockQuestions = deputadosQuestions.map((q, index) => ({
        code: q.code,
        text: q.text,
        surveyId: 2,
        totalResponses: 513,
      }));

      mockAnalysisService.getAvailableQuestions = jest
        .fn()
        .mockResolvedValue(mockQuestions);

      const response = await request(app).get('/api/questions?surveyId=2');

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toBeDefined();
      expect(response.body.count).toBe(deputadosQuestions.length);
      
      // Verificar se todas as perguntas esperadas estão presentes
      const returnedCodes = response.body.data.map((q: any) => q.code);
      deputadosQuestions.forEach((question) => {
        expect(returnedCodes).toContain(question.code);
      });
    });
  });

  describe('Teste de performance - todas as perguntas em sequência', () => {
    it('deve processar requisições para todas as perguntas sem timeout', async () => {
      mockAnalysisService.getChartData = jest.fn().mockImplementation((code) => {
        const question = deputadosQuestions.find((q) => q.code === code);
        return Promise.resolve({
          question: {
            code: code,
            text: question?.text || '',
          },
          chartData: {
            labels: ['A', 'B'],
            labelsDetailed: [
              { code: '1', label: 'A' },
              { code: '2', label: 'B' },
            ],
            datasets: [
              {
                data: [50, 50],
                backgroundColor: ['#FF6384', '#36A2EB'],
                borderColor: ['#FF6384', '#36A2EB'],
                borderWidth: 1,
              },
            ],
          },
          totalResponses: 100,
        });
      });

      // Fazer requisições para todas as perguntas
      const promises = deputadosQuestions.map((question) =>
        request(app).get(`/api/chart/${question.code}?surveyId=2`)
      );

      const responses = await Promise.all(promises);

      // Verificar que todas foram bem-sucedidas
      responses.forEach((response, index) => {
        expect(response.status).toBe(200);
        expect(response.body.success).toBe(true);
        expect(response.body.data.question.code).toBe(deputadosQuestions[index].code);
      });
    }, 60000); // Timeout de 60 segundos para este teste
  });
});
