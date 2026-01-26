--
-- PostgreSQL database dump - SCHEMA ONLY
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.0

-- Started on 2025-09-17 21:32:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
-- Set search_path to public schema
SET search_path TO public;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;



SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE surveys (
    id SERIAL PRIMARY KEY,
    code INTEGER UNIQUE NOT NULL,
    description VARCHAR(100) NOT NULL
);

--
-- TOC entry 215 (class 1259 OID 2784583)
-- Name: activity_sectors; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE activity_sectors (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(200) NOT NULL
);
--
-- TOC entry 238 (class 1259 OID 2784640)
-- Name: activity_sectors_extended; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE activity_sectors_extended (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE activity_sectors_extended; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.activity_sectors_extended IS 'Ramos de atividade para ATIVIDADE_RAMO';
--
-- TOC entry 216 (class 1259 OID 2784586)
-- Name: activity_sectors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.activity_sectors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.activity_sectors_id_seq OWNER TO postgres;
--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 216
-- Name: activity_sectors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.activity_sectors_id_seq OWNED BY public.activity_sectors.id;
--
-- TOC entry 217 (class 1259 OID 2784587)
-- Name: activity_statuses; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE activity_statuses (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(200) NOT NULL
);
--
-- TOC entry 239 (class 1259 OID 2784644)
-- Name: activity_statuses_extended; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE activity_statuses_extended (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE activity_statuses_extended; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.activity_statuses_extended IS 'Situações de atividade para ATIVIDADE_SITUACAO';
--
-- TOC entry 218 (class 1259 OID 2784590)
-- Name: activity_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.activity_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.activity_statuses_id_seq OWNER TO postgres;
--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 218
-- Name: activity_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.activity_statuses_id_seq OWNED BY public.activity_statuses.id;
--
-- TOC entry 219 (class 1259 OID 2784591)
-- Name: age_ranges; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE age_ranges (
    id integer NOT NULL,
    survey_id integer,
    code character varying(10) NOT NULL,
    description character varying(50) NOT NULL,
    min_age integer,
    max_age integer
);
--
-- TOC entry 220 (class 1259 OID 2784594)
-- Name: age_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.age_ranges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.age_ranges_id_seq OWNER TO postgres;
--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 220
-- Name: age_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.age_ranges_id_seq OWNED BY public.age_ranges.id;
--
-- TOC entry 221 (class 1259 OID 2784595)
-- Name: answer_groups; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE answer_groups (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);
--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE answer_groups; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.answer_groups IS 'Grupos de perguntas que compartilham os mesmos valores de resposta';
--
-- TOC entry 222 (class 1259 OID 2784601)
-- Name: answer_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.answer_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.answer_groups_id_seq OWNER TO postgres;
--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 222
-- Name: answer_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.answer_groups_id_seq OWNED BY public.answer_groups.id;
--
-- TOC entry 223 (class 1259 OID 2784602)
-- Name: answer_options; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE answer_options (
    id integer NOT NULL,
    answer_group_id integer NOT NULL,
    code character varying(20) NOT NULL,
    label text NOT NULL,
    option_order integer
);
--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE answer_options; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.answer_options IS 'Valores possÃ­veis para cada grupo de respostas';
--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN answer_options.option_order; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.answer_options.option_order IS 'Ordem das opções de resposta quando aplicável';
--
-- TOC entry 224 (class 1259 OID 2784607)
-- Name: answer_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.answer_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.answer_options_id_seq OWNER TO postgres;
--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 224
-- Name: answer_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.answer_options_id_seq OWNED BY public.answer_options.id;
--
-- TOC entry 225 (class 1259 OID 2784608)
-- Name: city_sizes; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE city_sizes (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 226 (class 1259 OID 2784611)
-- Name: city_sizes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.city_sizes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.city_sizes_id_seq OWNER TO postgres;
--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 226
-- Name: city_sizes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.city_sizes_id_seq OWNED BY public.city_sizes.id;
--
-- TOC entry 227 (class 1259 OID 2784612)
-- Name: education_levels; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE education_levels (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(200) NOT NULL,
    level_order integer
);
--
-- TOC entry 228 (class 1259 OID 2784615)
-- Name: education_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.education_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.education_levels_id_seq OWNER TO postgres;
--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 228
-- Name: education_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.education_levels_id_seq OWNED BY public.education_levels.id;
--
-- TOC entry 236 (class 1259 OID 2784632)
-- Name: first_round_candidates; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE first_round_candidates (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE first_round_candidates; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.first_round_candidates IS 'Candidatos do primeiro turno para questÃ£o P157';
--
-- TOC entry 229 (class 1259 OID 2784616)
-- Name: genders; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE genders (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(50) NOT NULL
);
--
-- TOC entry 230 (class 1259 OID 2784619)
-- Name: genders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.genders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.genders_id_seq OWNER TO postgres;
--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 230
-- Name: genders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.genders_id_seq OWNED BY public.genders.id;
--
-- TOC entry 240 (class 1259 OID 2784648)
-- Name: income_ranges; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE income_ranges (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE income_ranges; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.income_ranges IS 'Faixas de renda para RENDA_1';
--
-- TOC entry 231 (class 1259 OID 2784620)
-- Name: literacy_levels; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE literacy_levels (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 232 (class 1259 OID 2784623)
-- Name: literacy_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.literacy_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.literacy_levels_id_seq OWNER TO postgres;
--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 232
-- Name: literacy_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.literacy_levels_id_seq OWNED BY public.literacy_levels.id;
--
-- TOC entry 233 (class 1259 OID 2784624)
-- Name: occupations; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE occupations (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(200) NOT NULL
);
--
-- TOC entry 234 (class 1259 OID 2784627)
-- Name: occupations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.occupations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.occupations_id_seq OWNER TO postgres;
--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 234
-- Name: occupations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.occupations_id_seq OWNED BY public.occupations.id;
--
-- TOC entry 255 (class 1259 OID 2784800)
-- Name: political_parties; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE political_parties (
    id integer NOT NULL,
    code integer NOT NULL,
    name character varying(100) NOT NULL
);
--
-- TOC entry 241 (class 1259 OID 2784652)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE profiles (
    id integer NOT NULL,
    id_ipec bigint NOT NULL,
    survey_id integer,
    setor integer,
    state_id integer,
    city_size_id integer,
    region_id integer,
    gender_id integer,
    exact_age integer,
    age_range_id integer,
    race_id integer,
    literacy_id integer,
    education_id integer,
    activity_sector_id integer,
    activity_status_id integer,
    occupation_id integer,
    bathrooms integer,
    religion_id integer,
    vote_first_round_id integer,
    vote_second_round_id integer,
    income_range_id integer,
    political_party_id integer
);
--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE profiles; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.profiles IS 'Perfil demogrÃ¡fico dos respondentes da pesquisa';
--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.id_ipec; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.id_ipec IS 'ID original da pesquisa IPEC';
--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.activity_sector_id; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.activity_sector_id IS 'ID do ramo de atividade (ATIVIDADE_RAMO)';
--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.activity_status_id; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.activity_status_id IS 'ID da situação de atividade (ATIVIDADE_SITUACAO)';
--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.religion_id; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.religion_id IS 'ID da religiÃ£o do respondente (questÃ£o RELIGIAO)';
--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.vote_first_round_id; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.vote_first_round_id IS 'ID do voto no primeiro turno (questÃ£o P157)';
--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.vote_second_round_id; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.vote_second_round_id IS 'ID do voto no segundo turno (questÃ£o P159)';
--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN profiles.income_range_id; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.profiles.income_range_id IS 'ID da faixa de renda (RENDA_1)';
--
-- TOC entry 242 (class 1259 OID 2784657)
-- Name: races; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE races (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 243 (class 1259 OID 2784660)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE regions (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(100) NOT NULL
);
--
-- TOC entry 235 (class 1259 OID 2784628)
-- Name: religions; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE religions (
    id integer NOT NULL,
    survey_id integer,
    code integer NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE religions; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.religions IS 'Tipos de religiÃ£o para questÃ£o RELIGIAO';
--
-- TOC entry 237 (class 1259 OID 2784636)
-- Name: second_round_candidates; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE second_round_candidates (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    description character varying(100) NOT NULL
);
--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE second_round_candidates; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.second_round_candidates IS 'Candidatos do segundo turno para questÃ£o P159';
--
-- TOC entry 244 (class 1259 OID 2784663)
-- Name: states; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE states (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    region_id integer
);
--
-- TOC entry 245 (class 1259 OID 2784666)
-- Name: profile_analysis; Type: VIEW; Schema: public; Owner: postgres
--
CREATE VIEW public.profile_analysis AS
 SELECT p.id,
    p.id_ipec,
    p.setor,
    s.name AS state_name,
    s.code AS state_code,
    cs.description AS city_size,
    r.name AS region_name,
    g.description AS gender,
    p.exact_age,
    ar.description AS age_range,
    rc.description AS race,
    ll.description AS literacy_level,
    el.description AS education_level,
    asec.description AS activity_sector,
    ast.description AS activity_status,
    o.description AS occupation,
    rel.description AS religion,
    frc.description AS vote_first_round,
    src.description AS vote_second_round,
    asec_ext.description AS activity_sector_extended,
    ast_ext.description AS activity_status_extended,
    inc.description AS income_range,
    p.bathrooms
   FROM (((((((((((((((((public.profiles p
     LEFT JOIN public.states s ON ((p.state_id = s.id)))
     LEFT JOIN public.city_sizes cs ON ((p.city_size_id = cs.id)))
     LEFT JOIN public.regions r ON ((p.region_id = r.id)))
     LEFT JOIN public.genders g ON ((p.gender_id = g.id)))
     LEFT JOIN public.age_ranges ar ON ((p.age_range_id = ar.id)))
     LEFT JOIN public.races rc ON ((p.race_id = rc.id)))
     LEFT JOIN public.literacy_levels ll ON ((p.literacy_id = ll.id)))
     LEFT JOIN public.education_levels el ON ((p.education_id = el.id)))
     LEFT JOIN public.activity_sectors asec ON ((p.activity_sector_id = asec.id)))
     LEFT JOIN public.activity_statuses ast ON ((p.activity_status_id = ast.id)))
     LEFT JOIN public.occupations o ON ((p.occupation_id = o.id)))
     LEFT JOIN public.religions rel ON ((p.religion_id = rel.id)))
     LEFT JOIN public.first_round_candidates frc ON ((p.vote_first_round_id = frc.id)))
     LEFT JOIN public.second_round_candidates src ON ((p.vote_second_round_id = src.id)))
     LEFT JOIN public.activity_sectors_extended asec_ext ON ((p.activity_sector_id = asec_ext.id)))
     LEFT JOIN public.activity_statuses_extended ast_ext ON ((p.activity_status_id = ast_ext.id)))
     LEFT JOIN public.income_ranges inc ON ((p.income_range_id = inc.id)));
ALTER VIEW public.profile_analysis OWNER TO postgres;
--
-- TOC entry 246 (class 1259 OID 2784671)
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.profiles_id_seq OWNER TO postgres;
--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 246
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;
--
-- TOC entry 247 (class 1259 OID 2784672)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE questions (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    text text NOT NULL,
    answer_group_id integer,
    survey_id integer,
    question_order integer,
    is_active boolean DEFAULT true
);
--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE questions; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.questions IS 'Perguntas da pesquisa VoxDem';
--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN questions.question_order; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.questions.question_order IS 'Ordem da pergunta na pesquisa original';
--
-- TOC entry 248 (class 1259 OID 2784679)
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;
--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 248
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;
--
-- TOC entry 249 (class 1259 OID 2784680)
-- Name: races_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.races_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.races_id_seq OWNER TO postgres;
--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 249
-- Name: races_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.races_id_seq OWNED BY public.races.id;
--
-- TOC entry 250 (class 1259 OID 2784681)
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.regions_id_seq OWNER TO postgres;
--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 250
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;
--
-- TOC entry 251 (class 1259 OID 2784682)
-- Name: survey_responses; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE survey_responses (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_option_id integer,
    raw_value character varying(50)
);
--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE survey_responses; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON TABLE public.survey_responses IS 'Respostas dos participantes da pesquisa';
--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN survey_responses.raw_value; Type: COMMENT; Schema: public; Owner: postgres
--
COMMENT ON COLUMN public.survey_responses.raw_value IS 'Valor bruto da pesquisa para casos especiais nÃ£o mapeados';
--
-- TOC entry 252 (class 1259 OID 2784686)
-- Name: response_analysis; Type: VIEW; Schema: public; Owner: postgres
--
CREATE VIEW public.response_analysis AS
 SELECT sr.id,
    p.id_ipec,
    q.code AS question_code,
    q.text AS question_text,
    q.question_order,
    q.is_active,
    ao.code AS answer_code,
    ao.label AS answer_label,
    sr.raw_value,
    pa.gender,
    pa.age_range,
    pa.education_level,
    pa.race,
    pa.region_name,
    pa.state_name,
    pa.religion,
    pa.vote_first_round,
    pa.vote_second_round,
    pa.activity_sector_extended AS activity_sector,
    pa.activity_status_extended AS activity_status,
    pa.income_range
   FROM ((((public.survey_responses sr
     JOIN public.profiles p ON ((sr.profile_id = p.id)))
     JOIN public.questions q ON ((sr.question_id = q.id)))
     LEFT JOIN public.answer_options ao ON ((sr.answer_option_id = ao.id)))
     JOIN public.profile_analysis pa ON ((p.id = pa.id)));
ALTER VIEW public.response_analysis OWNER TO postgres;
--
-- TOC entry 253 (class 1259 OID 2784691)
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.states_id_seq OWNER TO postgres;
--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 253
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;
--
-- TOC entry 254 (class 1259 OID 2784692)
-- Name: survey_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE public.survey_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.survey_responses_id_seq OWNER TO postgres;
--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 254
-- Name: survey_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.survey_responses_id_seq OWNED BY public.survey_responses.id;
--
-- TOC entry 4796 (class 2604 OID 2784693)
-- Name: activity_sectors id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_sectors ALTER COLUMN id SET DEFAULT nextval('public.activity_sectors_id_seq'::regclass);
--
-- TOC entry 4797 (class 2604 OID 2784694)
-- Name: activity_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_statuses ALTER COLUMN id SET DEFAULT nextval('public.activity_statuses_id_seq'::regclass);
--
-- TOC entry 4798 (class 2604 OID 2784695)
-- Name: age_ranges id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY age_ranges ALTER COLUMN id SET DEFAULT nextval('public.age_ranges_id_seq'::regclass);
--
-- TOC entry 4799 (class 2604 OID 2784696)
-- Name: answer_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY answer_groups ALTER COLUMN id SET DEFAULT nextval('public.answer_groups_id_seq'::regclass);
--
-- TOC entry 4801 (class 2604 OID 2784697)
-- Name: answer_options id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY answer_options ALTER COLUMN id SET DEFAULT nextval('public.answer_options_id_seq'::regclass);
--
-- TOC entry 4802 (class 2604 OID 2784698)
-- Name: city_sizes id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY city_sizes ALTER COLUMN id SET DEFAULT nextval('public.city_sizes_id_seq'::regclass);
--
-- TOC entry 4803 (class 2604 OID 2784699)
-- Name: education_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY education_levels ALTER COLUMN id SET DEFAULT nextval('public.education_levels_id_seq'::regclass);
--
-- TOC entry 4804 (class 2604 OID 2784700)
-- Name: genders id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY genders ALTER COLUMN id SET DEFAULT nextval('public.genders_id_seq'::regclass);
--
-- TOC entry 4805 (class 2604 OID 2784701)
-- Name: literacy_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY literacy_levels ALTER COLUMN id SET DEFAULT nextval('public.literacy_levels_id_seq'::regclass);
--
-- TOC entry 4806 (class 2604 OID 2784702)
-- Name: occupations id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY occupations ALTER COLUMN id SET DEFAULT nextval('public.occupations_id_seq'::regclass);
--
-- TOC entry 4813 (class 2604 OID 2784703)
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);
--
-- TOC entry 4819 (class 2604 OID 2784704)
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);
--
-- TOC entry 4816 (class 2604 OID 2784705)
-- Name: races id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY races ALTER COLUMN id SET DEFAULT nextval('public.races_id_seq'::regclass);
--
-- TOC entry 4817 (class 2604 OID 2784706)
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);
--
-- TOC entry 4818 (class 2604 OID 2784707)
-- Name: states id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);
--
-- TOC entry 4822 (class 2604 OID 2784708)
-- Name: survey_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY survey_responses ALTER COLUMN id SET DEFAULT nextval('public.survey_responses_id_seq'::regclass);
--
-- TOC entry 5086 (class 0 OID 2784583)
-- Dependencies: 215
-- Data for Name: activity_sectors; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5109 (class 0 OID 2784640)
-- Dependencies: 238
-- Data for Name: activity_sectors_extended; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5088 (class 0 OID 2784587)
-- Dependencies: 217
-- Data for Name: activity_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5110 (class 0 OID 2784644)
-- Dependencies: 239
-- Data for Name: activity_statuses_extended; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5090 (class 0 OID 2784591)
-- Dependencies: 219
-- Data for Name: age_ranges; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5092 (class 0 OID 2784595)
-- Dependencies: 221
-- Data for Name: answer_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5094 (class 0 OID 2784602)
-- Dependencies: 223
-- Data for Name: answer_options; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5096 (class 0 OID 2784608)
-- Dependencies: 225
-- Data for Name: city_sizes; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5098 (class 0 OID 2784612)
-- Dependencies: 227
-- Data for Name: education_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5107 (class 0 OID 2784632)
-- Dependencies: 236
-- Data for Name: first_round_candidates; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5100 (class 0 OID 2784616)
-- Dependencies: 229
-- Data for Name: genders; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5111 (class 0 OID 2784648)
-- Dependencies: 240
-- Data for Name: income_ranges; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5102 (class 0 OID 2784620)
-- Dependencies: 231
-- Data for Name: literacy_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5104 (class 0 OID 2784624)
-- Dependencies: 233
-- Data for Name: occupations; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5112 (class 0 OID 2784652)
-- Dependencies: 241
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5117 (class 0 OID 2784672)
-- Dependencies: 247
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5113 (class 0 OID 2784657)
-- Dependencies: 242
-- Data for Name: races; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5114 (class 0 OID 2784660)
-- Dependencies: 243
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5106 (class 0 OID 2784628)
-- Dependencies: 235
-- Data for Name: religions; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5108 (class 0 OID 2784636)
-- Dependencies: 237
-- Data for Name: second_round_candidates; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5115 (class 0 OID 2784663)
-- Dependencies: 244
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5121 (class 0 OID 2784682)
-- Dependencies: 251
-- Data for Name: survey_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 216
-- Name: activity_sectors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 218
-- Name: activity_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 220
-- Name: age_ranges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 222
-- Name: answer_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 224
-- Name: answer_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 226
-- Name: city_sizes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 228
-- Name: education_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 230
-- Name: genders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 232
-- Name: literacy_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 234
-- Name: occupations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 246
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 248
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 249
-- Name: races_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 250
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 253
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 254
-- Name: survey_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--
--
-- TOC entry 4825 (class 2606 OID 2784710)
-- Name: activity_sectors activity_sectors_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_sectors
    ADD CONSTRAINT activity_sectors_code_key UNIQUE (code);
--
-- TOC entry 4876 (class 2606 OID 2784762)
-- Name: activity_sectors_extended activity_sectors_extended_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_sectors_extended
    ADD CONSTRAINT activity_sectors_extended_code_unique UNIQUE (code);
--
-- TOC entry 4878 (class 2606 OID 2784760)
-- Name: activity_sectors_extended activity_sectors_extended_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_sectors_extended
    ADD CONSTRAINT activity_sectors_extended_pkey PRIMARY KEY (id);
--
-- TOC entry 4827 (class 2606 OID 2784712)
-- Name: activity_sectors activity_sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_sectors
    ADD CONSTRAINT activity_sectors_pkey PRIMARY KEY (id);
--
-- TOC entry 4829 (class 2606 OID 2784714)
-- Name: activity_statuses activity_statuses_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_statuses
    ADD CONSTRAINT activity_statuses_code_key UNIQUE (code);
--
-- TOC entry 4880 (class 2606 OID 2784766)
-- Name: activity_statuses_extended activity_statuses_extended_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_statuses_extended
    ADD CONSTRAINT activity_statuses_extended_code_unique UNIQUE (code);
--
-- TOC entry 4882 (class 2606 OID 2784764)
-- Name: activity_statuses_extended activity_statuses_extended_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_statuses_extended
    ADD CONSTRAINT activity_statuses_extended_pkey PRIMARY KEY (id);
--
-- TOC entry 4831 (class 2606 OID 2784716)
-- Name: activity_statuses activity_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY activity_statuses
    ADD CONSTRAINT activity_statuses_pkey PRIMARY KEY (id);
--
-- TOC entry 4833 (class 2606 OID 2784718)
-- Name: age_ranges age_ranges_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY age_ranges
    ADD CONSTRAINT age_ranges_code_key UNIQUE (survey_id, code);
--
-- TOC entry 4835 (class 2606 OID 2784720)
-- Name: age_ranges age_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY age_ranges
    ADD CONSTRAINT age_ranges_pkey PRIMARY KEY (id);
--
-- TOC entry 4837 (class 2606 OID 2784722)
-- Name: answer_groups answer_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY answer_groups
    ADD CONSTRAINT answer_groups_pkey PRIMARY KEY (id);
--
-- TOC entry 4839 (class 2606 OID 2784724)
-- Name: answer_options answer_options_answer_group_id_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY answer_options
    ADD CONSTRAINT answer_options_answer_group_id_code_key UNIQUE (answer_group_id, code);
--
-- TOC entry 4841 (class 2606 OID 2784726)
-- Name: answer_options answer_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY answer_options
    ADD CONSTRAINT answer_options_pkey PRIMARY KEY (id);
--
-- TOC entry 4844 (class 2606 OID 2784728)
-- Name: city_sizes city_sizes_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY city_sizes
    ADD CONSTRAINT city_sizes_code_key UNIQUE (code);
--
-- TOC entry 4846 (class 2606 OID 2784730)
-- Name: city_sizes city_sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY city_sizes
    ADD CONSTRAINT city_sizes_pkey PRIMARY KEY (id);
--
-- TOC entry 4848 (class 2606 OID 2784732)
-- Name: education_levels education_levels_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY education_levels
    ADD CONSTRAINT education_levels_code_key UNIQUE (code);
--
-- TOC entry 4850 (class 2606 OID 2784734)
-- Name: education_levels education_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY education_levels
    ADD CONSTRAINT education_levels_pkey PRIMARY KEY (id);
--
-- TOC entry 4868 (class 2606 OID 2784754)
-- Name: first_round_candidates first_round_candidates_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY first_round_candidates
    ADD CONSTRAINT first_round_candidates_code_unique UNIQUE (code);
--
-- TOC entry 4870 (class 2606 OID 2784752)
-- Name: first_round_candidates first_round_candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY first_round_candidates
    ADD CONSTRAINT first_round_candidates_pkey PRIMARY KEY (id);
--
-- TOC entry 4852 (class 2606 OID 2784736)
-- Name: genders genders_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY genders
    ADD CONSTRAINT genders_code_key UNIQUE (code);
--
-- TOC entry 4854 (class 2606 OID 2784738)
-- Name: genders genders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY genders
    ADD CONSTRAINT genders_pkey PRIMARY KEY (id);
--
-- TOC entry 4884 (class 2606 OID 2784770)
-- Name: income_ranges income_ranges_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY income_ranges
    ADD CONSTRAINT income_ranges_code_unique UNIQUE (code);
--
-- TOC entry 4886 (class 2606 OID 2784768)
-- Name: income_ranges income_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY income_ranges
    ADD CONSTRAINT income_ranges_pkey PRIMARY KEY (id);
--
-- TOC entry 4856 (class 2606 OID 2784740)
-- Name: literacy_levels literacy_levels_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY literacy_levels
    ADD CONSTRAINT literacy_levels_code_key UNIQUE (code);
--
-- TOC entry 4858 (class 2606 OID 2784742)
-- Name: literacy_levels literacy_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY literacy_levels
    ADD CONSTRAINT literacy_levels_pkey PRIMARY KEY (id);
--
-- TOC entry 4860 (class 2606 OID 2784744)
-- Name: occupations occupations_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY occupations
    ADD CONSTRAINT occupations_code_key UNIQUE (code);
--
-- TOC entry 4862 (class 2606 OID 2784746)
-- Name: occupations occupations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY occupations
    ADD CONSTRAINT occupations_pkey PRIMARY KEY (id);
--
-- TOC entry 4889 (class 2606 OID 2784772)
-- Name: profiles profiles_id_ipec_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_id_ipec_key UNIQUE (id_ipec);
--
-- TOC entry 4891 (class 2606 OID 2784774)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);
--
-- TOC entry 4906 (class 2606 OID 2784776)
-- Name: questions questions_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_code_key UNIQUE (survey_id, code);
--
-- TOC entry 4908 (class 2606 OID 2784778)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
--
-- TOC entry 4893 (class 2606 OID 2784780)
-- Name: races races_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY races
    ADD CONSTRAINT races_code_key UNIQUE (code);
--
-- TOC entry 4895 (class 2606 OID 2784782)
-- Name: races races_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY races
    ADD CONSTRAINT races_pkey PRIMARY KEY (id);
--
-- TOC entry 4897 (class 2606 OID 2784784)
-- Name: regions regions_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_code_key UNIQUE (code);
--
-- TOC entry 4899 (class 2606 OID 2784786)
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
--
-- TOC entry 4864 (class 2606 OID 2784750)
-- Name: religions religions_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY religions
    ADD CONSTRAINT religions_code_unique UNIQUE (survey_id, code);
--
-- TOC entry 4866 (class 2606 OID 2784748)
-- Name: religions religions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY religions
    ADD CONSTRAINT religions_pkey PRIMARY KEY (id);
--
-- TOC entry 4872 (class 2606 OID 2784758)
-- Name: second_round_candidates second_round_candidates_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY second_round_candidates
    ADD CONSTRAINT second_round_candidates_code_unique UNIQUE (code);
--
-- TOC entry 4874 (class 2606 OID 2784756)
-- Name: second_round_candidates second_round_candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY second_round_candidates
    ADD CONSTRAINT second_round_candidates_pkey PRIMARY KEY (id);
--
-- TOC entry 4901 (class 2606 OID 2784788)
-- Name: states states_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY states
    ADD CONSTRAINT states_code_key UNIQUE (code);
--
-- TOC entry 4903 (class 2606 OID 2784790)
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);
--
-- TOC entry 4914 (class 2606 OID 2784792)
-- Name: survey_responses survey_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_pkey PRIMARY KEY (id);
--
-- TOC entry 4916 (class 2606 OID 2784794)
-- Name: survey_responses survey_responses_profile_id_question_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_profile_id_question_id_key UNIQUE (profile_id, question_id);
--
-- TOC entry 4842 (class 1259 OID 2784795)
-- Name: idx_answer_options_group; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_answer_options_group ON public.answer_options USING btree (answer_group_id, option_order);
--
-- TOC entry 4887 (class 1259 OID 2784796)
-- Name: idx_profiles_demographic; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_profiles_demographic ON public.profiles USING btree (gender_id, age_range_id, education_id, race_id);
--
-- TOC entry 4904 (class 1259 OID 2784797)
-- Name: idx_questions_active; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_questions_active ON public.questions USING btree (is_active, question_order);
--
-- TOC entry 4909 (class 1259 OID 2784798)
-- Name: idx_responses_analysis; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_responses_analysis ON public.survey_responses USING btree (question_id, answer_option_id);
--
-- TOC entry 4910 (class 1259 OID 2784799)
-- Name: idx_responses_profile; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_responses_profile ON public.survey_responses USING btree (profile_id);
--
-- TOC entry 4911 (class 1259 OID 2784800)
-- Name: idx_survey_responses_profile; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_survey_responses_profile ON public.survey_responses USING btree (profile_id);
--
-- TOC entry 4912 (class 1259 OID 2784801)
-- Name: idx_survey_responses_question; Type: INDEX; Schema: public; Owner: postgres
--
CREATE INDEX idx_survey_responses_question ON public.survey_responses USING btree (question_id);

--
-- TOC entry 4917 (class 2606 OID 2784803)
-- Name: answer_options answer_options_answer_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY answer_options
    ADD CONSTRAINT answer_options_answer_group_id_fkey FOREIGN KEY (answer_group_id) REFERENCES public.answer_groups(id);
--
-- TOC entry 4918 (class 2606 OID 2784878)
-- Name: profiles profiles_activity_sector_extended_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_activity_sector_extended_fkey FOREIGN KEY (activity_sector_id) REFERENCES public.activity_sectors_extended(id);
--
-- TOC entry 4919 (class 2606 OID 2784808)
-- Name: profiles profiles_activity_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_activity_sector_id_fkey FOREIGN KEY (activity_sector_id) REFERENCES public.activity_sectors(id);
--
-- TOC entry 4920 (class 2606 OID 2784883)
-- Name: profiles profiles_activity_status_extended_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_activity_status_extended_fkey FOREIGN KEY (activity_status_id) REFERENCES public.activity_statuses_extended(id);
--
-- TOC entry 4921 (class 2606 OID 2784813)
-- Name: profiles profiles_activity_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_activity_status_id_fkey FOREIGN KEY (activity_status_id) REFERENCES public.activity_statuses(id);
--
-- TOC entry 4922 (class 2606 OID 2784818)
-- Name: profiles profiles_age_range_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_age_range_id_fkey FOREIGN KEY (age_range_id) REFERENCES public.age_ranges(id);
--
-- TOC entry 4923 (class 2606 OID 2784823)
-- Name: profiles profiles_city_size_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_city_size_id_fkey FOREIGN KEY (city_size_id) REFERENCES public.city_sizes(id);
--
-- TOC entry 4924 (class 2606 OID 2784828)
-- Name: profiles profiles_education_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_education_id_fkey FOREIGN KEY (education_id) REFERENCES public.education_levels(id);
--
-- TOC entry 4925 (class 2606 OID 2784833)
-- Name: profiles profiles_gender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_gender_id_fkey FOREIGN KEY (gender_id) REFERENCES public.genders(id);
--
-- TOC entry 4926 (class 2606 OID 2784888)
-- Name: profiles profiles_income_range_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_income_range_fkey FOREIGN KEY (income_range_id) REFERENCES public.income_ranges(id);
--
-- TOC entry 4927 (class 2606 OID 2784838)
-- Name: profiles profiles_literacy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_literacy_id_fkey FOREIGN KEY (literacy_id) REFERENCES public.literacy_levels(id);
--
-- TOC entry 4928 (class 2606 OID 2784843)
-- Name: profiles profiles_occupation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_occupation_id_fkey FOREIGN KEY (occupation_id) REFERENCES public.occupations(id);
--
-- TOC entry 4929 (class 2606 OID 2784848)
-- Name: profiles profiles_race_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_race_id_fkey FOREIGN KEY (race_id) REFERENCES public.races(id);
--
-- TOC entry 4930 (class 2606 OID 2784853)
-- Name: profiles profiles_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id);
--
-- TOC entry 4931 (class 2606 OID 2784863)
-- Name: profiles profiles_religion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_religion_fkey FOREIGN KEY (religion_id) REFERENCES public.religions(id);
--
-- TOC entry 4932 (class 2606 OID 2784858)
-- Name: profiles profiles_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);
--
-- TOC entry 4933 (class 2606 OID 2784868)
-- Name: profiles profiles_vote_first_round_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_vote_first_round_fkey FOREIGN KEY (vote_first_round_id) REFERENCES public.first_round_candidates(id);
--
-- TOC entry 4934 (class 2606 OID 2784873)
-- Name: profiles profiles_vote_second_round_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_vote_second_round_fkey FOREIGN KEY (vote_second_round_id) REFERENCES public.second_round_candidates(id);
--
-- TOC entry 4936 (class 2606 OID 2784893)
-- Name: questions questions_answer_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_answer_group_id_fkey FOREIGN KEY (answer_group_id) REFERENCES public.answer_groups(id);
--
-- TOC entry 4935 (class 2606 OID 2784898)
-- Name: states states_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY states
    ADD CONSTRAINT states_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id);
--
-- TOC entry 4937 (class 2606 OID 2784903)
-- Name: survey_responses survey_responses_answer_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_answer_option_id_fkey FOREIGN KEY (answer_option_id) REFERENCES public.answer_options(id);
--
-- TOC entry 4938 (class 2606 OID 2784908)
-- Name: survey_responses survey_responses_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id);
--
-- TOC entry 4939 (class 2606 OID 2784913)
-- Name: survey_responses survey_responses_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);
--
--
