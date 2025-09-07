-- Script para criar sequências necessárias antes do dump principal
-- Este arquivo será executado primeiro pelo PostgreSQL

-- Conectar ao banco voxdem_survey (definido na variável POSTGRES_DB)
\c voxdem_survey;

-- Criar sequências para as tabelas
CREATE SEQUENCE IF NOT EXISTS activity_sectors_id_seq;
CREATE SEQUENCE IF NOT EXISTS activity_statuses_id_seq;
CREATE SEQUENCE IF NOT EXISTS age_ranges_id_seq;
CREATE SEQUENCE IF NOT EXISTS candidacy_status_id_seq;
CREATE SEQUENCE IF NOT EXISTS cities_id_seq;
CREATE SEQUENCE IF NOT EXISTS education_levels_id_seq;
CREATE SEQUENCE IF NOT EXISTS income_ranges_id_seq;
CREATE SEQUENCE IF NOT EXISTS marital_statuses_id_seq;
CREATE SEQUENCE IF NOT EXISTS occupations_id_seq;
CREATE SEQUENCE IF NOT EXISTS parties_id_seq;
CREATE SEQUENCE IF NOT EXISTS regions_id_seq;
CREATE SEQUENCE IF NOT EXISTS response_analysis_id_seq;
CREATE SEQUENCE IF NOT EXISTS response_categories_id_seq;
CREATE SEQUENCE IF NOT EXISTS states_id_seq;

-- Log da inicialização
SELECT 'Sequences created successfully in voxdem_survey' AS status;
