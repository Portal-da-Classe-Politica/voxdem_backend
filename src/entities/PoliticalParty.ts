import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('political_parties')
export class PoliticalParty {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'int', unique: true })
  code!: number;

  @Column({ type: 'varchar', length: 100 })
  name!: string;
}
