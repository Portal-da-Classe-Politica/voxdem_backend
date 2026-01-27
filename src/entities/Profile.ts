import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('profiles')
export class Profile {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'bigint' })
  id_ipec!: number;

  @Column({ type: 'int', nullable: true })
  survey_id!: number;

  @Column({ type: 'int', nullable: true })
  setor!: number;

  @Column({ type: 'int', nullable: true })
  state_id!: number;

  @Column({ type: 'int', nullable: true })
  city_size_id!: number;

  @Column({ type: 'int', nullable: true })
  region_id!: number;

  @Column({ type: 'int', nullable: true })
  gender_id!: number;

  @Column({ type: 'int', nullable: true })
  exact_age!: number;

  @Column({ type: 'int', nullable: true })
  age_range_id!: number;

  @Column({ type: 'int', nullable: true })
  race_id!: number;

  @Column({ type: 'int', nullable: true })
  literacy_id!: number;

  @Column({ type: 'int', nullable: true })
  education_id!: number;

  @Column({ type: 'int', nullable: true })
  activity_sector_id!: number;

  @Column({ type: 'int', nullable: true })
  activity_status_id!: number;

  @Column({ type: 'int', nullable: true })
  occupation_id!: number;

  // NOVOS ATRIBUTOS DE PERFIL
  @Column({ type: 'int', nullable: true })
  religion_id!: number;

  @Column({ type: 'int', nullable: true })
  vote_first_round_id!: number;

  @Column({ type: 'int', nullable: true })
  vote_second_round_id!: number;

  @Column({ type: 'int', nullable: true })
  income_range_id!: number;

  @Column({ type: 'int', nullable: true })
  political_party_id!: number; // Partido político (survey Deputados)

  @Column({ type: 'int', nullable: true })
  bathrooms!: number;


}

// Entidades para as tabelas de lookup dos novos atributos

@Entity('religions')
export class Religion {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}

@Entity('first_round_candidates')
export class FirstRoundCandidate {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}

@Entity('second_round_candidates')
export class SecondRoundCandidate {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}

@Entity('activity_sectors')
export class ActivitySectorExtended {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}

@Entity('activity_statuses')
export class ActivityStatusExtended {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}

@Entity('income_ranges')
export class IncomeRange {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'varchar', length: 20, unique: true })
  code!: string;

  @Column({ type: 'varchar', length: 100 })
  description!: string;
}

// View para análise de perfil com os novos atributos
@Entity('profile_analysis')
export class ProfileAnalysis {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: 'bigint' })
  id_ipec!: number;

  @Column({ type: 'int', nullable: true })
  setor!: number;

  @Column({ type: 'varchar', nullable: true })
  state_name!: string;

  @Column({ type: 'varchar', nullable: true })
  state_code!: string;

  @Column({ type: 'varchar', nullable: true })
  city_size!: string;

  @Column({ type: 'varchar', nullable: true })
  region_name!: string;

  @Column({ type: 'varchar', nullable: true })
  gender!: string;

  @Column({ type: 'int', nullable: true })
  exact_age!: number;

  @Column({ type: 'varchar', nullable: true })
  age_range!: string;

  @Column({ type: 'varchar', nullable: true })
  race!: string;

  @Column({ type: 'varchar', nullable: true })
  literacy_level!: string;

  @Column({ type: 'varchar', nullable: true })
  education_level!: string;

  @Column({ type: 'varchar', nullable: true })
  activity_sector!: string;

  @Column({ type: 'varchar', nullable: true })
  activity_status!: string;

  @Column({ type: 'varchar', nullable: true })
  occupation!: string;

  // NOVOS ATRIBUTOS DE PERFIL
  @Column({ type: 'varchar', nullable: true })
  religion!: string;

  @Column({ type: 'varchar', nullable: true })
  vote_first_round!: string;

  @Column({ type: 'varchar', nullable: true })
  vote_second_round!: string;

  @Column({ type: 'varchar', nullable: true })
  income_range!: string;

  @Column({ type: 'int', nullable: true })
  bathrooms!: number;
}
