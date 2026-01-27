import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('surveys')
export class Survey {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'int', unique: true })
  code!: number;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}
