import { Router, Request, Response } from 'express';
import { AnalysisService } from '../services/AnalysisService';

const router = Router();
const analysisService = new AnalysisService();

// 1. Listar todas as surveys disponíveis
router.get('/surveys', async (req: Request, res: Response) => {
  try {
    const surveys = await analysisService.getSurveys();
    
    res.json({
      success: true,
      data: surveys,
      count: surveys.length,
      generatedAt: new Date().toISOString()
    });
  } catch (error: any) {
    res.status(500).json({
      success: false,
      error: 'Erro ao buscar surveys',
      message: error.message
    });
  }
});

// 2. Listar todas as perguntas
router.get('/questions', async (req: Request, res: Response) => {
  try {
    const surveyId = req.query.surveyId ? parseInt(req.query.surveyId as string) : undefined;
    const questions = await analysisService.getAvailableQuestions(surveyId);
    
    res.json({
      success: true,
      data: questions,
      count: questions.length,
      generatedAt: new Date().toISOString()
    });
  } catch (error: any) {
    res.status(500).json({
      success: false,
      error: 'Erro ao buscar perguntas',
      message: error.message
    });
  }
});

// 3. Listar atributos de perfil
router.get('/profile-attributes', async (req: Request, res: Response) => {
  try {
    const attributes = await analysisService.getProfileAttributes();
    
    res.json({
      success: true,
      data: attributes,
      count: attributes.length,
      generatedAt: new Date().toISOString()
    });
  } catch (error: any) {
    res.status(500).json({
      success: false,
      error: 'Erro ao buscar atributos de perfil',
      message: error.message
    });
  }
});

// 4. Dados para gráfico simples (sem cruzamento)
router.get('/chart/:questionCode', async (req: Request, res: Response) => {
  try {
    const { questionCode } = req.params;
    const surveyId = req.query.surveyId ? parseInt(req.query.surveyId as string) : undefined;
    
    // Validação básica do código da pergunta (aceita P1, P3_1, P23A, etc.)
    if (!questionCode || !/^P[0-9]+(_[0-9]+)?[A-Z]*$/i.test(questionCode)) {
      return res.status(400).json({
        success: false,
        error: 'Código de pergunta inválido',
        message: 'O código deve seguir o padrão P01, P3_1, P23A, etc.'
      });
    }

    const chartData = await analysisService.getChartData(questionCode.toUpperCase(), surveyId);
    
    res.json({
      success: true,
      data: chartData,
      generatedAt: new Date().toISOString()
    });
  } catch (error: any) {
    if (error.message.includes('não encontrada')) {
      return res.status(404).json({
        success: false,
        error: 'Pergunta não encontrada',
        message: error.message
      });
    }
    
    res.status(500).json({
      success: false,
      error: 'Erro ao gerar dados do gráfico',
      message: error.message
    });
  }
});

// 5. Dados para gráfico com cruzamento por perfil
router.get('/chart/:questionCode/:profileAttribute', async (req: Request, res: Response) => {
  const { questionCode, profileAttribute } = req.params;
    const surveyId = req.query.surveyId ? parseInt(req.query.surveyId as string) : undefined;
  try {
    

    
    
    // Validação do código da pergunta (aceita P1, P3_1, P23A, etc.)
    if (!questionCode || !/^P[0-9]+(_[0-9]+)?[A-Z]*$/i.test(questionCode)) {
      return res.status(400).json({
        success: false,
        error: 'Código de pergunta inválido',
        message: 'O código deve seguir o padrão P01, P3_1, P23A, etc.'
      });
    }

    // Validação do atributo de perfil
    const validAttributes = ['gender', 'age_range', 'education', 'race', 'region', 
      'state', 'religion', 'vote_first_round', 'vote_second_round', 
      'activity_status', 'activity_sector', 'income_range', 'political_party'];
    if (!validAttributes.includes(profileAttribute)) {
      return res.status(400).json({
        success: false,
        error: 'Atributo de perfil inválido',
        message: `Atributos válidos: ${validAttributes.join(', ')}`
      });
    }

    const chartData = await analysisService.getChartDataWithProfile(
      questionCode.toUpperCase(), 
      profileAttribute,
      surveyId
    );
    
    res.json({
      success: true,
      data: chartData,
      generatedAt: new Date().toISOString()
    });
  } catch (error: any) {
    if (error.message.includes('não encontrada') || error.message.includes('não encontrado')) {
      return res.status(404).json({
        success: false,
        error: 'Recurso não encontrado',
        message: error.message
      });
    }
    
    res.status(500).json({
      success: false,
      error: 'Erro ao gerar dados do gráfico com perfil',
      aa: surveyId,
      message: error.message
    });
  }
});

export default router;
