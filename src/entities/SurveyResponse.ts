import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity('survey_responses')
export class SurveyResponse {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'int' })
  question_id!: number;

  @Column({ type: 'int' })
  answer_option_id!: number;

  @Column({ type: 'text', nullable: true })
  answer_text!: string; // Para respostas de texto livre

  @CreateDateColumn()
  created_at!: Date;
}
