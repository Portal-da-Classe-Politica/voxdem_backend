import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity('answer_groups')
export class AnswerGroup {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 100 })
  name!: string;

  @Column({ type: 'text', nullable: true })
  description!: string;

  @CreateDateColumn()
  created_at!: Date;
}

@Entity('answer_options')
export class AnswerOption {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'int' })
  answer_group_id!: number;

  @Column({ type: 'varchar', length: 20 })
  code!: string;

  @Column({ type: 'text' })
  label!: string;

  @Column({ type: 'int', default: 0 })
  option_order!: number;

  @CreateDateColumn()
  created_at!: Date;
}
