import { config } from 'dotenv';
import { DataSource } from 'typeorm';
import { Question } from './entities/Question';
import { AnswerGroup, AnswerOption } from './entities/Answer';
import { SurveyResponse } from './entities/SurveyResponse';
import { Profile, ProfileAnalysis, Religion, FirstRoundCandidate, SecondRoundCandidate, ActivitySectorExtended, ActivityStatusExtended, IncomeRange } from './entities/Profile';

// Load environment variables from .env file
config();

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: process.env.DATABASE_HOST || process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DATABASE_PORT || process.env.DB_PORT || '5433'),
  username: process.env.DATABASE_USER || process.env.DB_USERNAME || 'postgres',
  password: process.env.DATABASE_PASSWORD || process.env.DB_PASSWORD || 'postgres',
  database: process.env.DATABASE_NAME || process.env.DB_NAME || 'voxdem_survey',
  synchronize: false, // Não sincronizar automaticamente - banco já existe
  logging: process.env.NODE_ENV === 'development',
  entities: [
    Question, 
    AnswerGroup, 
    AnswerOption, 
    SurveyResponse, 
    Profile, 
    ProfileAnalysis, 
    Religion, 
    FirstRoundCandidate, 
    SecondRoundCandidate,
    ActivitySectorExtended,
    ActivityStatusExtended,
    IncomeRange
  ],
});