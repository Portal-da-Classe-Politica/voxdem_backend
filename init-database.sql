-- =====================================================
-- VoxDem Survey Database Initialization Script
-- =====================================================
-- This script creates the database schema and loads all data
-- Execution order:
-- 1. Drop existing database (if needed)
-- 2. Create schema (tables, indexes, constraints)
-- 3. Load lookup/reference tables (common tables)
-- 4. Load questions (general population + deputados)
-- 5. Load answer options
-- 6. Load profiles (general population + deputados)
-- 7. Load survey responses (general population + deputados)
-- =====================================================

-- Ensure we're using UTF8 encoding
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

-- Start timing
\timing on

-- Display progress messages
\echo '==========================================='
\echo 'Starting VoxDem Database Initialization'
\echo '==========================================='

-- =====================================================
-- STEP 1: Create Schema (Tables, Indexes, Constraints)
-- =====================================================
\echo ''
\echo '[1/6] Creating database schema...'
\i /docker-entrypoint-initdb.d/sqlinserts/voxdem_schema.sql

-- =====================================================
-- STEP 2: Load Common/Lookup Tables
-- =====================================================
\echo ''
\echo '[2/7] Loading common and lookup tables...'
\i /docker-entrypoint-initdb.d/sqlinserts/voxdem_data_common_tables_insert.sql

-- =====================================================
-- STEP 3: Load Answer Groups (BEFORE Answer Options - FK dependency)
-- =====================================================
\echo ''
\echo '[3/7] Loading answer groups...'
\i /docker-entrypoint-initdb.d/sqlinserts/answer_groups_insert.sql



-- =====================================================
-- STEP 4: Load Answer Options (ALL - shared between surveys)
-- =====================================================
\echo ''
\echo '[4/10] Loading answer options...'
\i /docker-entrypoint-initdb.d/sqlinserts/voxdem_answer_options_insert.sql

-- =====================================================
-- STEP 5: Load Questions
-- =====================================================
\echo ''
\echo '[5/10] Loading general population questions...'
\i /docker-entrypoint-initdb.d/sqlinserts/voxdem_questions_insert.sql

\echo ''
\echo '[6/10] Loading deputados questions...'
\i /docker-entrypoint-initdb.d/sqlinserts/deputados_questions_insert.sql

-- =====================================================
-- STEP 6: Load Profiles
-- =====================================================
\echo ''
\echo '[7/10] Loading general population profiles...'
\i /docker-entrypoint-initdb.d/sqlinserts/voxde_data_profiles_insert.sql

\echo ''
\echo '[8/10] Loading deputados profiles...'
\i /docker-entrypoint-initdb.d/sqlinserts/deputados_profiles_insert.sql

-- =====================================================
-- STEP 7: Load Survey Responses
-- =====================================================
\echo ''
\echo '[9/10] Loading general population responses (~310k rows - may take 1-2 minutes)...'
\i /docker-entrypoint-initdb.d/sqlinserts/voxdem_data_responses_insert.sql

\echo ''
\echo '[10/10] Loading deputados responses (~4k rows)...'
\i /docker-entrypoint-initdb.d/sqlinserts/deputados_responses_insert.sql

-- =====================================================
-- STEP 8: Load Clivagens Survey (Survey 3)
-- =====================================================
\echo ''
\echo '[11/15] Loading clivagens common tables (municipalities, professions)...'
\i /docker-entrypoint-initdb.d/sqlinserts/clivagens_data_common_tables_insert.sql

\echo ''
\echo '[12/15] Loading clivagens answer groups...'
\i /docker-entrypoint-initdb.d/sqlinserts/clivagens_answer_groups_insert.sql

\echo ''
\echo '[13/15] Loading clivagens answer options...'
\i /docker-entrypoint-initdb.d/sqlinserts/clivagens_answer_options_insert.sql

\echo ''
\echo '[14/15] Loading clivagens questions...'
\i /docker-entrypoint-initdb.d/sqlinserts/clivagens_questions_insert.sql

\echo ''
\echo '[15/15] Loading clivagens profiles (1500 rows)...'
\i /docker-entrypoint-initdb.d/sqlinserts/clivagens_profiles_insert.sql

\echo ''
\echo '[16/15] Loading clivagens responses (~76k rows)...'
\i /docker-entrypoint-initdb.d/sqlinserts/clivagens_responses_insert.sql

-- =====================================================
-- Finalization
-- =====================================================
\echo ''
\echo '==========================================='
\echo 'Database initialization complete!'
\echo '==========================================='

-- Analyze tables for query optimization
\echo ''
\echo 'Analyzing tables for query optimization...'
ANALYZE;

-- Display table counts
\echo ''
\echo 'Database Statistics:'
\echo '-------------------'

SELECT 'Surveys' as table_name, COUNT(*) as row_count FROM public.surveys
UNION ALL
SELECT 'Profiles (Total)', COUNT(*) FROM public.profiles
UNION ALL
SELECT 'Profiles (Survey 1 - General)', COUNT(*) FROM public.profiles WHERE survey_id = 1
UNION ALL
SELECT 'Profiles (Survey 2 - Deputados)', COUNT(*) FROM public.profiles WHERE survey_id = 2
UNION ALL
SELECT 'Profiles (Survey 3 - Clivagens)', COUNT(*) FROM public.profiles WHERE survey_id = 3
UNION ALL
SELECT 'Questions (Total)', COUNT(*) FROM public.questions
UNION ALL
SELECT 'Questions (Survey 1)', COUNT(*) FROM public.questions WHERE survey_id = 1
UNION ALL
SELECT 'Questions (Survey 2)', COUNT(*) FROM public.questions WHERE survey_id = 2
UNION ALL
SELECT 'Questions (Survey 3 - Clivagens)', COUNT(*) FROM public.questions WHERE survey_id = 3
UNION ALL
SELECT 'Answer Options', COUNT(*) FROM public.answer_options
UNION ALL
SELECT 'Survey Responses (Total)', COUNT(*) FROM public.survey_responses
UNION ALL
SELECT 'Responses (Survey 1)', COUNT(*) FROM public.survey_responses sr JOIN public.profiles p ON sr.profile_id = p.id WHERE p.survey_id = 1
UNION ALL
SELECT 'Responses (Survey 2)', COUNT(*) FROM public.survey_responses sr JOIN public.profiles p ON sr.profile_id = p.id WHERE p.survey_id = 2
UNION ALL
SELECT 'Responses (Survey 3 - Clivagens)', COUNT(*) FROM public.survey_responses sr JOIN public.profiles p ON sr.profile_id = p.id WHERE p.survey_id = 3
UNION ALL
SELECT 'States', COUNT(*) FROM public.states
UNION ALL
SELECT 'Regions', COUNT(*) FROM public.regions
UNION ALL
SELECT 'Genders', COUNT(*) FROM public.genders
UNION ALL
SELECT 'Age Ranges', COUNT(*) FROM public.age_ranges
UNION ALL
SELECT 'Races', COUNT(*) FROM public.races
UNION ALL
SELECT 'Education Levels', COUNT(*) FROM public.education_levels
UNION ALL
SELECT 'Religions', COUNT(*) FROM public.religions
UNION ALL
SELECT 'Income Ranges', COUNT(*) FROM public.income_ranges
ORDER BY table_name;

\echo ''
\echo '✓ All data loaded successfully!'
