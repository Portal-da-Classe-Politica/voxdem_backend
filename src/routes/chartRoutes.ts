import { Router, Request, Response } from 'express';
import { AnalysisService } from '../services/AnalysisService';

const router = Router();
const analysisService = new AnalysisService();

// 1. Listar todas as perguntas
router.get('/questions', async (req: Request, res: Response) => {
  try {
    const questions = await analysisService.getAvailableQuestions();
    
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

// 2. Listar atributos de perfil
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

// 3. Dados para gráfico simples (sem cruzamento)
router.get('/chart/:questionCode', async (req: Request, res: Response) => {
  try {
    const { questionCode } = req.params;
    
    // Validação básica do código da pergunta
    if (!questionCode || !/^P[0-9]+[A-Z]*$/i.test(questionCode)) {
      return res.status(400).json({
        success: false,
        error: 'Código de pergunta inválido',
        message: 'O código deve seguir o padrão P01, P23A, etc.'
      });
    }

    const chartData = await analysisService.getChartData(questionCode.toUpperCase());
    
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

// 4. Dados para gráfico com cruzamento por perfil
router.get('/chart/:questionCode/:profileAttribute', async (req: Request, res: Response) => {
  try {
    const { questionCode, profileAttribute } = req.params;
    
    // Validação do código da pergunta
    if (!questionCode || !/^P[0-9]+[A-Z]*$/i.test(questionCode)) {
      return res.status(400).json({
        success: false,
        error: 'Código de pergunta inválido',
        message: 'O código deve seguir o padrão P01, P23A, etc.'
      });
    }

    // Validação do atributo de perfil
    const validAttributes = ['gender', 'age_range', 'education', 'race', 'region', 'state'];
    if (!validAttributes.includes(profileAttribute)) {
      return res.status(400).json({
        success: false,
        error: 'Atributo de perfil inválido',
        message: `Atributos válidos: ${validAttributes.join(', ')}`
      });
    }

    const chartData = await analysisService.getChartDataWithProfile(
      questionCode.toUpperCase(), 
      profileAttribute
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
      message: error.message
    });
  }
});

export default router;
