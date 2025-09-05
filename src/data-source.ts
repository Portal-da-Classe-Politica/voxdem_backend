import { DataSource } from 'typeorm';
import { Question } from './entities/Question';
import { AnswerGroup, AnswerOption } from './entities/Answer';
import { SurveyResponse } from './entities/SurveyResponse';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  username: process.env.DB_USERNAME || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
  database: process.env.DB_NAME || 'voxdem_survey',
  synchronize: false, // Não sincronizar automaticamente - banco já existe
  logging: process.env.NODE_ENV === 'development',
  entities: [Question, AnswerGroup, AnswerOption, SurveyResponse],
});
