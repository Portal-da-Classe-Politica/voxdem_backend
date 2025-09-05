import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

@Entity('questions')
export class Question {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string; // Código da pergunta (ex: P01, P02A)

  @Column({ type: 'text' })
  text!: string; // Texto da pergunta

  @Column({ type: 'int' })
  answer_group_id!: number; // ID do grupo de respostas

  @Column({ type: 'varchar', length: 100, nullable: true })
  variable_name!: string; // Nome da variável no dataset original

  @Column({ type: 'int', default: 0 })
  sort_order!: number;

  @Column({ type: 'boolean', default: true })
  is_active!: boolean;

  @CreateDateColumn()
  created_at!: Date;

  @UpdateDateColumn()
  updated_at!: Date;
}
