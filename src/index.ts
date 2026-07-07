import 'reflect-metadata';
import { config } from 'dotenv';
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';


config();
import { AppDataSource } from './data-source';
import chartRoutes from './routes/chartRoutes';

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares de segurança e logging
app.use(helmet());
app.use(cors());
app.use(morgan('combined'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Rota inicial
app.get('/', (req, res) => {
  res.json({
    message: 'VoxDem API - Análise Simplificada para Gráficos',
    version: '2.0.0',
    endpoints: {
      surveys: 'GET /api/surveys - Lista todas as surveys disponíveis',
      questions: 'GET /api/questions - Lista todas as perguntas',
      profiles: 'GET /api/profile-attributes - Lista atributos de perfil', 
      simpleChart: 'GET /api/chart/:questionCode - Dados para gráfico simples',
      profileChart: 'GET /api/chart/:questionCode/:profileAttribute - Dados para gráfico com perfil'
    },
    chartjs: 'Dados otimizados para Chart.js',
    documentation: 'Ver README.md para exemplos de uso'
  });
});

// Usar as rotas de gráficos
app.use('/api', chartRoutes);

// Health check
app.get('/api/health', async (req, res) => {
  try {
    // Teste simples de conectividade
    await AppDataSource.query('SELECT 1');
    
    res.json({
      success: true,
      status: 'healthy',
      database: 'connected',
      api: 'VoxDem Chart API',
      version: '2.0.0',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    res.status(503).json({
      success: false,
      status: 'unhealthy',
      database: 'disconnected',
      error: 'Database connection failed'
    });
  }
});

// Middleware para rotas não encontradas
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    error: 'Endpoint não encontrado',
    message: `Rota ${req.method} ${req.originalUrl} não existe`,
    availableEndpoints: [
      'GET /api/surveys',
      'GET /api/questions',
      'GET /api/profile-attributes',
      'GET /api/chart/:questionCode',
      'GET /api/chart/:questionCode/:profileAttribute'
    ]
  });
});

// Middleware global de tratamento de erros
app.use((error: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
  console.error('❌ Erro não tratado:', error);
  
  res.status(500).json({
    success: false,
    error: 'Erro interno do servidor',
    message: process.env.NODE_ENV === 'development' ? error.message : 'Entre em contato com o suporte'
  });
});

// Inicializar conexão com banco, com retry (o container do Postgres pode
// responder "healthy" no healthcheck antes de aceitar conexões de fato,
// especialmente no primeiro deploy, quando os sqlinserts ainda estão
// carregando — isso causava ECONNREFUSED e derrubava o processo de vez).
async function connectWithRetry(maxRetries = 10, delayMs = 3000) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      await AppDataSource.initialize();
      console.log('✅ Conexão com PostgreSQL estabelecida');
      return;
    } catch (error) {
      console.error(`❌ Tentativa ${attempt}/${maxRetries} de conectar ao banco falhou:`, (error as Error).message);
      if (attempt === maxRetries) throw error;
      await new Promise((resolve) => setTimeout(resolve, delayMs));
    }
  }
}

// Inicializar conexão com banco e servidor
async function startServer() {
  try {
    await connectWithRetry();

    app.listen(PORT, () => {
      console.log('🚀 Servidor VoxDem Chart API rodando na porta', PORT);
      console.log('📊 API Simplificada para Gráficos - Chart.js Ready');
      console.log('🌐 Acesse: http://localhost:' + PORT);
      console.log('🏥 Health check: http://localhost:' + PORT + '/api/health');
      console.log('� Lista de surveys: http://localhost:' + PORT + '/api/surveys');
      console.log('�📋 Lista de perguntas: http://localhost:' + PORT + '/api/questions');
      console.log('👥 Atributos de perfil: http://localhost:' + PORT + '/api/profile-attributes');
      console.log('📈 Exemplo gráfico simples: http://localhost:' + PORT + '/api/chart/P01');
      console.log('📊 Exemplo gráfico com perfil: http://localhost:' + PORT + '/api/chart/P01/gender');
    });
  } catch (error) {
    console.error('❌ Erro ao inicializar servidor:', error);
    process.exit(1);
  }
}

startServer();
