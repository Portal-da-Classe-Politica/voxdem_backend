-- Script de inicialização do banco VoxDem Survey
-- Este arquivo pode ser usado tanto no Docker quanto em servidores externos
-- Versão: 2.0 - Compatível com diferentes ambientes

-- Verificar se o banco existe, se não, criar
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'voxdem_survey') THEN
        PERFORM dblink_exec('host=localhost user=postgres', 'CREATE DATABASE voxdem_survey');
    END IF;
END
$$;

-- Conectar ao banco voxdem_survey
\c voxdem_survey;

-- Criar extensões necessárias se não existirem
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";

-- Criar sequências para as tabelas (se não existirem)
CREATE SEQUENCE IF NOT EXISTS activity_sectors_id_seq;
CREATE SEQUENCE IF NOT EXISTS activity_statuses_id_seq;
CREATE SEQUENCE IF NOT EXISTS age_ranges_id_seq;
CREATE SEQUENCE IF NOT EXISTS answer_groups_id_seq;
CREATE SEQUENCE IF NOT EXISTS answer_options_id_seq;
CREATE SEQUENCE IF NOT EXISTS city_sizes_id_seq;
CREATE SEQUENCE IF NOT EXISTS education_levels_id_seq;
CREATE SEQUENCE IF NOT EXISTS genders_id_seq;
CREATE SEQUENCE IF NOT EXISTS literacy_levels_id_seq;
CREATE SEQUENCE IF NOT EXISTS occupations_id_seq;
CREATE SEQUENCE IF NOT EXISTS profiles_id_seq;
CREATE SEQUENCE IF NOT EXISTS question_groups_id_seq;
CREATE SEQUENCE IF NOT EXISTS questions_id_seq;
CREATE SEQUENCE IF NOT EXISTS races_id_seq;
CREATE SEQUENCE IF NOT EXISTS regions_id_seq;
CREATE SEQUENCE IF NOT EXISTS states_id_seq;
CREATE SEQUENCE IF NOT EXISTS survey_responses_id_seq;
CREATE SEQUENCE IF NOT EXISTS candidacy_status_id_seq;
CREATE SEQUENCE IF NOT EXISTS cities_id_seq;
CREATE SEQUENCE IF NOT EXISTS income_ranges_id_seq;
CREATE SEQUENCE IF NOT EXISTS marital_statuses_id_seq;
CREATE SEQUENCE IF NOT EXISTS parties_id_seq;
CREATE SEQUENCE IF NOT EXISTS response_analysis_id_seq;
CREATE SEQUENCE IF NOT EXISTS response_categories_id_seq;

-- Log da inicialização
SELECT 
    'VoxDem Survey Database initialized successfully' AS status,
    current_database() AS database_name,
    current_user AS connected_user,
    version() AS postgresql_version;
