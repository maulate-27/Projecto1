--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: candidato; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.candidato (
    id integer NOT NULL,
    nrcandidato integer NOT NULL,
    nome character varying(100),
    apelido character varying(100),
    genero character(1),
    pais character varying(100),
    prov_nasc character varying(100),
    prov_resi character varying(100),
    nacionalidade character varying(100),
    estcivil character varying(20),
    data_nasc date,
    regime character varying(100),
    delegacao character varying(100),
    escopu character varying(100),
    opcao1 integer,
    opcao2 integer,
    tipoest character varying(100),
    bi character varying(13),
    CONSTRAINT candidato_genero_check CHECK ((genero = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.candidato OWNER TO maulate;

--
-- Name: candidato_id_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

ALTER TABLE public.candidato ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.candidato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: curso; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.curso (
    seq integer NOT NULL,
    codigo character varying(10) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    descricao character varying(100) NOT NULL,
    regime_id integer NOT NULL,
    faculcod integer,
    codgr integer
);


ALTER TABLE public.curso OWNER TO maulate;

--
-- Name: curso_disciplinas; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.curso_disciplinas (
    curso_id integer NOT NULL,
    disciplina_id integer NOT NULL
);


ALTER TABLE public.curso_disciplinas OWNER TO maulate;

--
-- Name: curso_seq_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

CREATE SEQUENCE public.curso_seq_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.curso_seq_seq OWNER TO maulate;

--
-- Name: curso_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maulate
--

ALTER SEQUENCE public.curso_seq_seq OWNED BY public.curso.seq;


--
-- Name: delegacao; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.delegacao (
    delegid integer NOT NULL,
    designacao character varying(100) NOT NULL,
    abrev character varying(100)
);


ALTER TABLE public.delegacao OWNER TO maulate;

--
-- Name: delegacao_delegid_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

ALTER TABLE public.delegacao ALTER COLUMN delegid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.delegacao_delegid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: disciplinas; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.disciplinas (
    id integer NOT NULL,
    coddisc character varying(10) NOT NULL,
    designacao character varying(100) NOT NULL,
    data date,
    hora time without time zone,
    horaentrada time without time zone,
    ordem integer,
    subj character varying(10)
);


ALTER TABLE public.disciplinas OWNER TO maulate;

--
-- Name: disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

CREATE SEQUENCE public.disciplinas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplinas_id_seq OWNER TO maulate;

--
-- Name: disciplinas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maulate
--

ALTER SEQUENCE public.disciplinas_id_seq OWNED BY public.disciplinas.id;


--
-- Name: escolapreu; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.escolapreu (
    codesc integer NOT NULL,
    designacao character varying(150),
    provid integer
);


ALTER TABLE public.escolapreu OWNER TO maulate;

--
-- Name: faculdade; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.faculdade (
    cod integer NOT NULL,
    designacao character varying(100),
    abrev character varying(100)
);


ALTER TABLE public.faculdade OWNER TO maulate;

--
-- Name: faculdade_cod_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

CREATE SEQUENCE public.faculdade_cod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faculdade_cod_seq OWNER TO maulate;

--
-- Name: faculdade_cod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maulate
--

ALTER SEQUENCE public.faculdade_cod_seq OWNED BY public.faculdade.cod;


--
-- Name: grupos; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.grupos (
    gr integer NOT NULL,
    codgr integer NOT NULL,
    designacao character varying(100)
);


ALTER TABLE public.grupos OWNER TO maulate;

--
-- Name: grupos_gr_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

CREATE SEQUENCE public.grupos_gr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupos_gr_seq OWNER TO maulate;

--
-- Name: grupos_gr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maulate
--

ALTER SEQUENCE public.grupos_gr_seq OWNED BY public.grupos.gr;


--
-- Name: localidade; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.localidade (
    provid integer NOT NULL,
    designacao character varying(100)
);


ALTER TABLE public.localidade OWNER TO maulate;

--
-- Name: localidade_provid_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

CREATE SEQUENCE public.localidade_provid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localidade_provid_seq OWNER TO maulate;

--
-- Name: localidade_provid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maulate
--

ALTER SEQUENCE public.localidade_provid_seq OWNED BY public.localidade.provid;


--
-- Name: regime; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.regime (
    id integer NOT NULL,
    nome character varying(20) NOT NULL,
    descricao character varying(100)
);


ALTER TABLE public.regime OWNER TO maulate;

--
-- Name: regime_id_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

CREATE SEQUENCE public.regime_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regime_id_seq OWNER TO maulate;

--
-- Name: regime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maulate
--

ALTER SEQUENCE public.regime_id_seq OWNED BY public.regime.id;


--
-- Name: sala_candidato; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.sala_candidato (
    id integer NOT NULL,
    provincia character varying(100),
    nrcandidato integer NOT NULL,
    nome character varying(100),
    opcao1 character varying(100),
    opcao2 character varying(100),
    disciplina character varying(100),
    local character varying(100),
    sala character varying(50) NOT NULL
);


ALTER TABLE public.sala_candidato OWNER TO maulate;

--
-- Name: sala_candidato_id_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

ALTER TABLE public.sala_candidato ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sala_candidato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: salas; Type: TABLE; Schema: public; Owner: maulate
--

CREATE TABLE public.salas (
    salaid integer NOT NULL,
    local character varying(100) NOT NULL,
    nrsala character varying(50) NOT NULL,
    provincia integer,
    prioridade integer DEFAULT 0,
    ordem integer DEFAULT 0,
    capacidade integer NOT NULL,
    nrvigilante integer DEFAULT 0,
    emuso boolean DEFAULT false,
    CONSTRAINT salas_capacidade_check CHECK ((capacidade >= 0))
);


ALTER TABLE public.salas OWNER TO maulate;

--
-- Name: salas_salaid_seq; Type: SEQUENCE; Schema: public; Owner: maulate
--

ALTER TABLE public.salas ALTER COLUMN salaid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.salas_salaid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: curso seq; Type: DEFAULT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso ALTER COLUMN seq SET DEFAULT nextval('public.curso_seq_seq'::regclass);


--
-- Name: disciplinas id; Type: DEFAULT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.disciplinas ALTER COLUMN id SET DEFAULT nextval('public.disciplinas_id_seq'::regclass);


--
-- Name: faculdade cod; Type: DEFAULT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.faculdade ALTER COLUMN cod SET DEFAULT nextval('public.faculdade_cod_seq'::regclass);


--
-- Name: grupos gr; Type: DEFAULT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.grupos ALTER COLUMN gr SET DEFAULT nextval('public.grupos_gr_seq'::regclass);


--
-- Name: localidade provid; Type: DEFAULT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.localidade ALTER COLUMN provid SET DEFAULT nextval('public.localidade_provid_seq'::regclass);


--
-- Name: regime id; Type: DEFAULT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.regime ALTER COLUMN id SET DEFAULT nextval('public.regime_id_seq'::regclass);


--
-- Data for Name: candidato; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.candidato (id, nrcandidato, nome, apelido, genero, pais, prov_nasc, prov_resi, nacionalidade, estcivil, data_nasc, regime, delegacao, escopu, opcao1, opcao2, tipoest, bi) FROM stdin;
1	3648	Irina	Carvalho	F	Mocambique	Maputo	Cabo Delgado	Mocambicana	C	2006-06-15	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	49	47	Superior	664050176263R
2	3649	Ema	Matias	F	Mocambique	Tete	Nampula	Mocambicana	S	1995-11-08	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	49	51	Superior	834110699158M
3	3650	Clara	Rodrigues	M	Mocambique	Maputo	Sofala	Mocambicana	C	2005-08-12	Laboral	UP-Lichinga	Colegio Arco-iris	41	42	Superior	626995693915T
4	3651	Vera	Coelho	M	Mocambique	Maputo	Maputo	Mocambicana	C	2002-08-28	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	39	41	Superior	003184666794R
5	3652	Gaspar	Ferreira	M	Mocambique	Gaza	Cabo Delgado	Mocambicana	C	2003-04-23	Laboral	UP-Xai-Xai	Colegio Arco-iris	61	62	Superior	368884141161I
6	3653	Ariana	Cunha	M	Mocambique	Tete	Sofala	Mocambicana	D	2004-08-16	Laboral	UP-Massinga	Escola Secundária da Maxixe	36	63	Superior	297766639946F
7	3654	Paulo	Nogueira	M	Mocambique	Tete	Nampula	Mocambicana	S	1997-04-17	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	64	60	Superior	433209535727G
8	3655	Rafaela	Baptista	F	Mocambique	Cidade de Maputo	Gaza	Mocambicana	V	1998-01-03	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	52	47	Superior	949261979520B
9	3656	Patrícia	Fernandes	F	Mocambique	Cabo Delgado	Cabo Delgado	Mocambicana	D	1997-07-19	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	46	45	Superior	736031295502C
10	3657	Benjamim	Ramos	M	Mocambique	Nampula	Zambézia	Mocambicana	S	2005-10-03	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	63	59	Superior	179464870788G
11	3658	Gonçalo	Vaz	F	Mocambique	Maputo	Sofala	Mocambicana	S	1998-09-13	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	56	48	Superior	367414994185E
12	3659	Matilde	Pinto	F	Mocambique	Gaza	Nampula	Mocambicana	S	1998-10-15	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	41	62	Superior	016581290764B
13	3660	Soraia	Castro	M	Mocambique	Tete	Nampula	Mocambicana	S	1995-09-27	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	43	38	Superior	639512824296F
14	3661	Erica	Cardoso	F	Mocambique	Maputo	Cidade de Maputo	Mocambicana	D	2003-10-22	Laboral	UP-Quelimane	Escola Secundária da Maxixe	56	66	Superior	064746255884X
15	3662	Matias	Paiva	M	Mocambique	Sofala	Inhambane	Mocambicana	D	1999-04-02	Pos-Laboral	UP-Massinga	Colegio Arco-iris	48	40	Superior	242001001596R
16	3663	Paulo	Pinto	M	Mocambique	Tete	Tete	Mocambicana	C	2003-08-22	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	63	51	Superior	390638633013B
17	3664	Ema	Amorim	F	Mocambique	Manica	Gaza	Mocambicana	D	1996-12-29	Laboral	UP-Quelimane	Escola Secundária da Maxixe	63	52	Superior	031601445630N
18	3665	Vera	Baptista	F	Mocambique	Tete	Sofala	Mocambicana	S	1995-09-25	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	61	43	Superior	473693940920V
19	3666	Núria	Santos	M	Mocambique	Cidade de Maputo	Nampula	Mocambicana	D	2000-06-04	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	68	52	Superior	146431238508D
20	3667	Lucas	Almeida	M	Mocambique	Sofala	Manica	Mocambicana	V	2004-08-20	Laboral	UP-Quelimane	Escola Secundária da Maxixe	39	36	Superior	089030216009U
21	3668	Laura	Cunha	F	Mocambique	Nampula	Niassa	Mocambicana	V	2002-06-15	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	44	58	Superior	450290382736T
22	3669	Francisco	Pires	M	Mocambique	Nampula	Cidade de Maputo	Mocambicana	C	2001-03-05	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	38	68	Superior	198828940713K
23	3670	David	Vaz	M	Mocambique	Niassa	Maputo	Mocambicana	V	1995-12-08	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	53	41	Superior	811652136387A
24	3671	William	Cunha	F	Mocambique	Nampula	Maputo	Mocambicana	V	2004-12-15	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	37	63	Superior	912593172508K
25	3672	Valentina	Alves	M	Mocambique	Zambézia	Niassa	Mocambicana	C	1999-04-02	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	54	42	Superior	646957418391W
26	3673	Micael	Amorim	M	Mocambique	Nampula	Tete	Mocambicana	S	1996-10-14	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	46	63	Superior	611164323682S
27	3674	Carolina	Valente	M	Mocambique	Inhambane	Nampula	Mocambicana	D	2002-10-29	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	68	67	Superior	603038936380L
28	3675	André	Matias	F	Mocambique	Inhambane	Cabo Delgado	Mocambicana	C	2002-12-03	Laboral	UP-Lichinga	Colegio Arco-iris	56	37	Superior	915439544930V
29	3676	Júlia	Lima	F	Mocambique	Gaza	Gaza	Mocambicana	D	1998-06-25	Pos-Laboral	UP-Gurue	Colegio Arco-iris	58	67	Superior	705868247063F
30	3677	Ismael	Fonseca	F	Mocambique	Inhambane	Inhambane	Mocambicana	S	2005-10-17	Laboral	UP-Lichinga	Escola Secundária da Maxixe	36	44	Superior	344545491079B
31	3678	Érica	Gonçalves	F	Mocambique	Gaza	Inhambane	Mocambicana	D	2005-11-15	Laboral	UP-Lichinga	Escola Secundária da Maxixe	58	67	Superior	316301542870L
32	3679	Miriam	Matias	F	Mocambique	Maputo	Maputo	Mocambicana	C	1997-10-13	Laboral	UP-Quelimane	Colegio Arco-iris	60	44	Superior	065218694584H
33	3680	Naiara	Andrade	F	Mocambique	Tete	Manica	Mocambicana	S	2006-09-17	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	38	52	Superior	651042726301O
34	3681	Santiago	Rocha	F	Mocambique	Zambézia	Tete	Mocambicana	S	2000-02-09	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	38	42	Superior	704904646654X
35	3682	Tiago	Martins	M	Mocambique	Niassa	Cabo Delgado	Mocambicana	D	1995-12-30	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	39	68	Superior	249690197434Y
36	3683	Beatriz	Teixeira	F	Mocambique	Maputo	Zambézia	Mocambicana	V	2003-09-03	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	40	47	Superior	108314682325F
37	3684	Mafalda	Loureiro	M	Mocambique	Sofala	Cidade de Maputo	Mocambicana	D	1998-12-31	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	59	36	Superior	742640712411E
38	3685	Flor	Almeida	F	Mocambique	Zambézia	Gaza	Mocambicana	S	2003-11-10	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	67	68	Superior	637974030375H
39	3686	Marco	Coelho	M	Mocambique	Cidade de Maputo	Maputo	Mocambicana	S	2000-03-04	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	62	39	Superior	327112365257B
40	3687	Artur	Araújo	M	Mocambique	Sofala	Cidade de Maputo	Mocambicana	C	2001-02-23	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	61	58	Superior	767223596378R
41	3688	Mateus	Miranda	F	Mocambique	Maputo	Niassa	Mocambicana	S	2005-10-25	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	54	66	Superior	287341995782B
42	3689	Lara	Matias	F	Mocambique	Sofala	Manica	Mocambicana	S	2006-02-04	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	36	39	Superior	291513375283N
43	3690	José	Amaral	M	Mocambique	Niassa	Gaza	Mocambicana	C	2005-03-24	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	66	48	Superior	555453921951E
44	3691	Amélia	Cruz	F	Mocambique	Maputo	Tete	Mocambicana	V	2003-09-30	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	58	54	Superior	544619496888B
45	3692	Débora	Antunes	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	D	2006-05-23	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	41	59	Superior	959140449193Z
46	3693	Sandro	Tavares	F	Mocambique	Cabo Delgado	Manica	Mocambicana	C	2000-04-12	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	49	35	Superior	281759941162N
47	3694	Denis	Lima	F	Mocambique	Tete	Cabo Delgado	Mocambicana	C	2004-02-10	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	56	38	Superior	127071088415O
48	3695	Luís	Abreu	M	Mocambique	Nampula	Cabo Delgado	Mocambicana	V	2006-11-26	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	36	52	Superior	466379705372B
49	3696	Nádia	Vicente	F	Mocambique	Maputo	Manica	Mocambicana	S	2005-12-26	Laboral	UP-Gurue	Escola Secundária da Maxixe	58	67	Superior	748095872949D
50	3697	Violeta	Gonçalves	F	Mocambique	Gaza	Sofala	Mocambicana	C	2006-11-27	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	50	38	Superior	509114114840H
51	3698	Lisandro	Guerreiro	M	Mocambique	Gaza	Nampula	Mocambicana	C	1998-07-26	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	50	68	Superior	623287315255M
52	3699	Sofia	Pinho	F	Mocambique	Maputo	Sofala	Mocambicana	S	1999-10-12	Laboral	UP-Quelimane	Colegio Arco-iris	67	42	Superior	694856284812Y
53	3700	Iara	Nascimento	M	Mocambique	Tete	Niassa	Mocambicana	V	1995-04-01	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	47	61	Superior	396253611773B
54	3701	Cláudio	Freitas	M	Mocambique	Gaza	Cidade de Maputo	Mocambicana	D	2002-08-13	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	41	56	Superior	884791018774J
55	3702	Pilar	Fernandes	F	Mocambique	Gaza	Gaza	Mocambicana	V	1999-07-27	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	40	56	Superior	179446694184U
56	3703	Fernando	Monteiro	F	Mocambique	Manica	Nampula	Mocambicana	V	2000-03-01	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	57	38	Superior	459737447578L
57	3704	Artur	Leite	M	Mocambique	Manica	Inhambane	Mocambicana	D	2003-11-22	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	48	39	Superior	145547546593J
58	3705	Cláudio	Paiva	F	Mocambique	Inhambane	Manica	Mocambicana	D	2005-07-14	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	35	57	Superior	191126029108J
59	3706	Manuel	Domingues	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	D	1999-01-02	Laboral	UP-Xai-Xai	Colegio Arco-iris	58	50	Superior	703077771109I
60	3707	Inês	Assunção	M	Mocambique	Gaza	Tete	Mocambicana	D	1998-10-03	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	43	66	Superior	510404455474U
61	3708	Violeta	Amorim	F	Mocambique	Inhambane	Maputo	Mocambicana	C	2005-07-27	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	59	40	Superior	196915747787K
62	3709	Teresa	Abreu	F	Mocambique	Cidade de Maputo	Inhambane	Mocambicana	C	1996-05-26	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	50	35	Superior	086392491611L
63	3710	Laura	Almeida	M	Mocambique	Manica	Tete	Mocambicana	V	2001-01-10	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	37	52	Superior	028102103916X
64	3711	Jéssica	Monteiro	F	Mocambique	Tete	Cidade de Maputo	Mocambicana	V	1996-04-09	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	37	44	Superior	377978011166E
65	3712	Naiara	Ramos	F	Mocambique	Nampula	Gaza	Mocambicana	V	2006-03-03	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	53	56	Superior	198291417410P
66	3713	Ângela	Araújo	M	Mocambique	Sofala	Inhambane	Mocambicana	C	2001-01-29	Laboral	UP-Xai-Xai	Colegio Arco-iris	41	44	Superior	608016725418Q
67	3714	Leonor	Nunes	M	Mocambique	Maputo	Zambézia	Mocambicana	V	1999-07-21	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	64	68	Superior	550845761925F
68	3715	Eduarda	Melo	M	Mocambique	Zambézia	Cidade de Maputo	Mocambicana	C	1998-10-30	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	60	63	Superior	185748428131U
69	3716	Mia	Araújo	M	Mocambique	Cidade de Maputo	Maputo	Mocambicana	D	2000-03-23	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	48	55	Superior	686925035707S
70	3717	António	Gomes	M	Mocambique	Gaza	Nampula	Mocambicana	D	2003-09-26	Pos-Laboral	UP-Gurue	Colegio Arco-iris	60	37	Superior	934273960911S
71	3718	Frederico	Valente	M	Mocambique	Nampula	Zambézia	Mocambicana	D	1996-01-21	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	42	50	Superior	598897304659Y
72	3719	Raquel	Morais	M	Mocambique	Gaza	Tete	Mocambicana	S	2004-11-30	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	47	51	Superior	868061816783I
73	3720	Enzo	Almeida	M	Mocambique	Maputo	Maputo	Mocambicana	C	1996-04-05	Laboral	UP-Gurue	Colegio Arco-iris	38	57	Superior	430896455978M
74	3721	Gaspar	Brito	F	Mocambique	Niassa	Zambézia	Mocambicana	D	2003-11-21	Laboral	UP-Lichinga	Colegio Arco-iris	58	57	Superior	374696044350D
75	3722	Rafaela	Nascimento	F	Mocambique	Sofala	Sofala	Mocambicana	D	1999-05-30	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	42	43	Superior	842678571771S
76	3723	Patrícia	Andrade	M	Mocambique	Cabo Delgado	Niassa	Mocambicana	V	2006-10-15	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	41	68	Superior	338585139972M
77	3724	Tomás	Azevedo	F	Mocambique	Inhambane	Cabo Delgado	Mocambicana	D	2006-10-27	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	41	61	Superior	633656356715C
78	3725	Henrique	Vieira	F	Mocambique	Cabo Delgado	Nampula	Mocambicana	D	1998-09-01	Laboral	UP-Quelimane	Colegio Arco-iris	54	61	Superior	848896399383R
79	3726	Rúben	Cruz	M	Mocambique	Zambézia	Zambézia	Mocambicana	S	2003-04-13	Laboral	UP-Gurue	Escola Secundária da Maxixe	50	42	Superior	867402527430P
80	3727	Nuno	Costa	F	Mocambique	Manica	Zambézia	Mocambicana	C	1998-06-03	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	59	66	Superior	577995827826P
81	3728	Rita	Loureiro	F	Mocambique	Gaza	Cabo Delgado	Mocambicana	V	1997-03-20	Laboral	UP-Quelimane	Escola Secundária da Maxixe	43	48	Superior	106462282688U
82	3729	Vitória	Machado	F	Mocambique	Inhambane	Cabo Delgado	Mocambicana	S	2002-01-19	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	66	55	Superior	716202596423I
83	3730	Flor	Marques	F	Mocambique	Sofala	Tete	Mocambicana	D	1998-04-06	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	65	37	Superior	261819864277D
84	3731	Ivo	Jesus	F	Mocambique	Inhambane	Nampula	Mocambicana	D	2003-08-24	Laboral	UP-Massinga	Escola Secundária da Maxixe	36	66	Superior	911818999599G
85	3732	Noah	Sá	M	Mocambique	Niassa	Sofala	Mocambicana	D	2005-04-19	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	42	51	Superior	702980907681R
86	3733	Valentina	Ribeiro	M	Mocambique	Zambézia	Zambézia	Mocambicana	V	2004-12-12	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	46	41	Superior	286278103975I
87	3734	Letícia	Figueiredo	M	Mocambique	Inhambane	Sofala	Mocambicana	S	2002-10-03	Laboral	UP-Lichinga	Escola Secundária da Maxixe	48	67	Superior	886576867313E
88	3735	Duarte	Baptista	M	Mocambique	Cidade de Maputo	Cabo Delgado	Mocambicana	C	1998-01-31	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	68	44	Superior	848832956051A
89	3736	Mário	Gaspar	F	Mocambique	Nampula	Nampula	Mocambicana	D	2006-08-12	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	43	59	Superior	803400214950W
90	3737	Nádia	Morais	F	Mocambique	Sofala	Cabo Delgado	Mocambicana	S	2005-08-03	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	67	54	Superior	778517461532Q
91	3738	Isabel	Matias	F	Mocambique	Nampula	Manica	Mocambicana	C	2001-01-02	Pos-Laboral	UP-Gurue	Colegio Arco-iris	42	49	Superior	611893305936E
92	3739	Daniela	Ribeiro	F	Mocambique	Nampula	Cabo Delgado	Mocambicana	S	2001-01-28	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	43	51	Superior	597785986940S
93	3740	Daniela	Branco	M	Mocambique	Niassa	Gaza	Mocambicana	D	2006-04-17	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	61	64	Superior	472600563448O
94	3741	Brian	Amaral	F	Mocambique	Zambézia	Inhambane	Mocambicana	C	2005-02-05	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	39	51	Superior	094666729940H
95	3742	Lara	Freitas	M	Mocambique	Niassa	Niassa	Mocambicana	C	1998-01-22	Laboral	UP-Gurue	Colegio Arco-iris	37	54	Superior	893294790286D
96	3743	Margarida	Paiva	M	Mocambique	Maputo	Tete	Mocambicana	V	1998-06-23	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	40	64	Superior	919700700687T
97	3744	Yasmin	Morais	F	Mocambique	Zambézia	Zambézia	Mocambicana	C	2001-08-15	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	39	56	Superior	065740530548Q
98	3745	Íris	Pinheiro	M	Mocambique	Maputo	Cabo Delgado	Mocambicana	V	1995-09-16	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	40	39	Superior	737131584393U
99	3746	Paulo	Amaral	F	Mocambique	Niassa	Niassa	Mocambicana	S	2001-06-18	Pos-Laboral	UP-Massinga	Colegio Arco-iris	48	64	Superior	787751261190W
100	3747	Ana	Baptista	F	Mocambique	Cabo Delgado	Tete	Mocambicana	V	2002-10-11	Laboral	UP-Gurue	Colegio Arco-iris	51	53	Superior	164783494122Z
101	3748	Anita	Tavares	F	Mocambique	Cabo Delgado	Inhambane	Mocambicana	S	1997-02-06	Laboral	UP-Xai-Xai	Colegio Arco-iris	40	60	Superior	202520336364X
102	3749	Fábio	Cruz	F	Mocambique	Tete	Maputo	Mocambicana	C	1998-08-20	Laboral	UP-Lichinga	Colegio Arco-iris	50	60	Superior	262242454090V
103	3750	Francisco	Tavares	F	Mocambique	Sofala	Cabo Delgado	Mocambicana	C	2003-09-10	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	35	51	Superior	229722964782E
104	3751	Luciana	Rodrigues	F	Mocambique	Zambézia	Maputo	Mocambicana	S	2003-11-19	Laboral	UP-Massinga	Colegio Arco-iris	42	41	Superior	571712516797A
105	3752	Luís	Martins	F	Mocambique	Niassa	Cabo Delgado	Mocambicana	C	2003-10-24	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	61	63	Superior	336403134198N
106	3753	Ricardo	Amorim	M	Mocambique	Zambézia	Tete	Mocambicana	S	1998-05-27	Laboral	UP-Quelimane	Escola Secundária da Maxixe	40	41	Superior	674827649309D
107	3754	Flor	Leal	M	Mocambique	Zambézia	Manica	Mocambicana	C	1995-08-12	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	66	35	Superior	956404472450R
108	3755	João	Teixeira	F	Mocambique	Nampula	Maputo	Mocambicana	S	2006-04-14	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	38	55	Superior	889216258923L
109	3756	Amélia	Gonçalves	M	Mocambique	Zambézia	Nampula	Mocambicana	C	1997-06-22	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	40	68	Superior	605490092454E
110	3757	Sérgio	Leite	F	Mocambique	Nampula	Nampula	Mocambicana	S	1996-01-27	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	54	64	Superior	401329341882J
111	3758	Márcio	Ramos	M	Mocambique	Manica	Tete	Mocambicana	V	1996-07-23	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	60	68	Superior	338730253519W
112	3759	Carlota	Campos	F	Mocambique	Cabo Delgado	Cabo Delgado	Mocambicana	S	2005-07-11	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	65	41	Superior	302814143961V
113	3760	Anita	Rocha	F	Mocambique	Manica	Maputo	Mocambicana	S	2006-11-29	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	37	65	Superior	711456466949G
114	3761	Tiago	Almeida	M	Mocambique	Cabo Delgado	Niassa	Mocambicana	D	2005-02-19	Pos-Laboral	UP-Gurue	Colegio Arco-iris	53	66	Superior	760991252938E
115	3762	André	Vieira	F	Mocambique	Nampula	Cabo Delgado	Mocambicana	V	2000-01-29	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	51	37	Superior	287997657749B
116	3763	Daniel	Rodrigues	M	Mocambique	Cabo Delgado	Manica	Mocambicana	V	2001-03-27	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	40	52	Superior	214662894588U
117	3764	Carlota	Oliveira	F	Mocambique	Cabo Delgado	Sofala	Mocambicana	S	1997-12-10	Laboral	UP-Quelimane	Colegio Arco-iris	43	65	Superior	866824998331T
118	3765	Anita	Neto	M	Mocambique	Tete	Tete	Mocambicana	V	2002-09-20	Laboral	UP-Lichinga	Escola Secundária da Maxixe	42	65	Superior	935324425421T
119	3766	Melissa	Fernandes	M	Mocambique	Sofala	Maputo	Mocambicana	V	2002-02-08	Laboral	UP-Lichinga	Escola Secundária da Maxixe	59	54	Superior	219171366008C
120	3767	Ângela	Silva	M	Mocambique	Manica	Tete	Mocambicana	C	2001-09-16	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	41	66	Superior	909591294152H
121	3768	Matilde	Cardoso	M	Mocambique	Manica	Zambézia	Mocambicana	D	2006-08-20	Laboral	UP-Lichinga	Escola Secundária da Maxixe	61	43	Superior	361877801517E
122	3769	Gabriel	Paiva	F	Mocambique	Zambézia	Manica	Mocambicana	V	1999-11-04	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	55	40	Superior	789135369715B
123	3770	Benjamim	Nogueira	M	Mocambique	Manica	Tete	Mocambicana	C	1999-02-06	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	52	41	Superior	845255616841M
124	3771	Frederico	Simões	F	Mocambique	Manica	Sofala	Mocambicana	V	1998-12-31	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	60	38	Superior	901582488168W
125	3772	Hugo	Matos	F	Mocambique	Tete	Zambézia	Mocambicana	D	1999-05-30	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	54	62	Superior	438816353230B
126	3773	César	Ribeiro	F	Mocambique	Niassa	Sofala	Mocambicana	S	2004-01-03	Laboral	UP-Quelimane	Escola Secundária da Maxixe	61	57	Superior	625969302078A
127	3774	Victória	Simões	F	Mocambique	Nampula	Sofala	Mocambicana	D	1996-02-18	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	44	38	Superior	774365153169C
128	3775	Débora	Vicente	F	Mocambique	Sofala	Manica	Mocambicana	D	1995-03-04	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	40	53	Superior	713230016540F
129	3776	Victória	Lourenço	M	Mocambique	Inhambane	Maputo	Mocambicana	V	2006-05-29	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	61	40	Superior	322425851595T
130	3777	Sofia	Nunes	M	Mocambique	Manica	Manica	Mocambicana	C	2004-10-16	Laboral	UP-Lichinga	Escola Secundária da Maxixe	60	49	Superior	415328274078B
131	3778	Bruno	Moreira	M	Mocambique	Niassa	Inhambane	Mocambicana	S	2004-07-31	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	53	36	Superior	591898943314K
132	3779	Salomé	Assunção	M	Mocambique	Nampula	Sofala	Mocambicana	D	2002-08-31	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	36	41	Superior	651505981598F
133	3780	Leonardo	Amorim	M	Mocambique	Niassa	Maputo	Mocambicana	V	1995-06-06	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	62	36	Superior	926669286360D
134	3781	Adriana	Azevedo	M	Mocambique	Gaza	Nampula	Mocambicana	C	2003-10-30	Laboral	UP-Gurue	Escola Secundária da Maxixe	49	52	Superior	093017191942L
135	3782	Matilde	Pires	M	Mocambique	Sofala	Maputo	Mocambicana	C	2006-07-09	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	41	50	Superior	894617073109F
136	3783	Renato	Pinto	M	Mocambique	Zambézia	Sofala	Mocambicana	V	2003-11-04	Laboral	UP-Massinga	Escola Secundária da Maxixe	43	63	Superior	371084929325K
137	3784	Martim	Valente	M	Mocambique	Maputo	Cabo Delgado	Mocambicana	V	1998-12-04	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	50	56	Superior	435336909354H
138	3785	Valentina	Azevedo	M	Mocambique	Inhambane	Gaza	Mocambicana	C	2000-04-04	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	35	62	Superior	689196551376N
139	3786	Sara	Oliveira	F	Mocambique	Tete	Zambézia	Mocambicana	V	2002-07-10	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	67	37	Superior	800231418897E
140	3787	Melissa	Correia	F	Mocambique	Niassa	Sofala	Mocambicana	S	1999-02-04	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	53	68	Superior	263431015450Q
141	3788	Alexandra	Ferreira	F	Mocambique	Niassa	Maputo	Mocambicana	V	1999-06-19	Laboral	UP-Lichinga	Colegio Arco-iris	35	63	Superior	607284936423B
142	3789	Fabiana	Castro	M	Mocambique	Cabo Delgado	Manica	Mocambicana	C	1996-02-20	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	39	47	Superior	491065170245S
143	3790	Melissa	Monteiro	F	Mocambique	Cidade de Maputo	Inhambane	Mocambicana	S	1995-08-08	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	62	60	Superior	957977166415W
144	3791	Benjamim	Nunes	F	Mocambique	Maputo	Nampula	Mocambicana	V	1996-11-10	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	39	48	Superior	805383750668U
145	3792	Ângelo	Oliveira	F	Mocambique	Cidade de Maputo	Zambézia	Mocambicana	S	1997-04-22	Laboral	UP-Massinga	Escola Secundária da Maxixe	56	66	Superior	761923828422A
146	3793	Sebastião	Moreira	F	Mocambique	Cabo Delgado	Manica	Mocambicana	V	2006-01-26	Laboral	UP-Lichinga	Colegio Arco-iris	67	55	Superior	310117113664S
147	3794	Yasmin	Lopes	M	Mocambique	Inhambane	Cabo Delgado	Mocambicana	C	2006-11-25	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	44	43	Superior	743660128934T
148	3795	Diego	Mendes	M	Mocambique	Manica	Nampula	Mocambicana	V	2004-03-02	Laboral	UP-Gurue	Colegio Arco-iris	49	43	Superior	495193670310G
149	3796	Victória	Almeida	F	Mocambique	Cidade de Maputo	Cidade de Maputo	Mocambicana	S	2006-05-20	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	38	61	Superior	277578909772W
150	3797	Alícia	Castro	F	Mocambique	Maputo	Nampula	Mocambicana	C	2006-05-28	Laboral	UP-Gurue	Colegio Arco-iris	44	57	Superior	289737867892C
151	3798	Vitória	Faria	F	Mocambique	Manica	Cidade de Maputo	Mocambicana	S	1998-05-20	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	66	43	Superior	089728182278G
152	3799	Jorge	Assunção	M	Mocambique	Inhambane	Nampula	Mocambicana	C	1997-11-18	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	62	57	Superior	218018617604V
153	3800	Lúcia	Morais	F	Mocambique	Inhambane	Maputo	Mocambicana	S	2005-05-30	Laboral	UP-Xai-Xai	Colegio Arco-iris	50	66	Superior	691068272995S
154	3801	Dinis	Abreu	M	Mocambique	Cabo Delgado	Maputo	Mocambicana	S	1999-02-13	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	36	41	Superior	740397698789W
155	3802	Tatiana	Andrade	M	Mocambique	Cabo Delgado	Tete	Mocambicana	D	2004-11-07	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	38	46	Superior	824314214277B
156	3803	Leonardo	Anjos	M	Mocambique	Tete	Niassa	Mocambicana	C	2006-04-28	Laboral	UP-Quelimane	Escola Secundária da Maxixe	57	53	Superior	406464313753X
157	3804	Fábio	Faria	F	Mocambique	Nampula	Tete	Mocambicana	C	2002-03-10	Laboral	UP-Gurue	Escola Secundária da Maxixe	55	44	Superior	112384326457U
158	3805	Luana	Carneiro	F	Mocambique	Manica	Cidade de Maputo	Mocambicana	C	2000-02-13	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	37	50	Superior	811579451707X
159	3806	Nuno	Nascimento	F	Mocambique	Sofala	Gaza	Mocambicana	D	2000-02-28	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	45	68	Superior	155300005059M
160	3807	Wilson	Santos	M	Mocambique	Tete	Cabo Delgado	Mocambicana	V	1996-01-05	Laboral	UP-Quelimane	Colegio Arco-iris	48	45	Superior	644207887036F
161	3808	Luana	Pinho	F	Mocambique	Manica	Manica	Mocambicana	S	1999-02-07	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	42	38	Superior	825773414033S
162	3809	Tomás	Leal	F	Mocambique	Inhambane	Manica	Mocambicana	V	1997-03-25	Laboral	UP-Xai-Xai	Colegio Arco-iris	46	53	Superior	762578082440T
163	3810	Isaac	Castro	M	Mocambique	Gaza	Gaza	Mocambicana	S	2005-04-13	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	45	51	Superior	158396080057A
164	3811	Rúben	Reis	F	Mocambique	Nampula	Inhambane	Mocambicana	D	1995-07-28	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	55	58	Superior	499371428009M
165	3812	Letícia	Matias	F	Mocambique	Inhambane	Niassa	Mocambicana	C	2005-04-22	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	51	40	Superior	862632874802H
166	3813	Rita	Araújo	M	Mocambique	Cidade de Maputo	Cidade de Maputo	Mocambicana	S	2006-07-08	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	44	59	Superior	204123764107L
167	3814	David	Rodrigues	F	Mocambique	Zambézia	Sofala	Mocambicana	C	2004-07-02	Laboral	UP-Massinga	Escola Secundária da Maxixe	36	54	Superior	110090807438N
168	3815	Daniela	Macedo	F	Mocambique	Sofala	Maputo	Mocambicana	C	2002-10-23	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	68	46	Superior	895760997947G
169	3816	Alícia	Anjos	F	Mocambique	Inhambane	Inhambane	Mocambicana	C	2004-01-24	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	53	59	Superior	053058568558U
170	3817	Jorge	Batista	M	Mocambique	Gaza	Nampula	Mocambicana	S	2004-11-23	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	62	47	Superior	173726709318O
171	3818	Ivan	Torres	F	Mocambique	Nampula	Sofala	Mocambicana	C	2002-07-15	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	65	66	Superior	463523958651Y
172	3819	Igor	Sá	F	Mocambique	Gaza	Niassa	Mocambicana	C	2003-03-27	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	36	55	Superior	822547937036Q
173	3820	Vicente	Pacheco	M	Mocambique	Sofala	Cidade de Maputo	Mocambicana	V	2002-01-17	Laboral	UP-Gurue	Escola Secundária da Maxixe	54	62	Superior	150545339192X
174	3821	César	Ribeiro	F	Mocambique	Cidade de Maputo	Maputo	Mocambicana	V	1997-10-25	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	50	61	Superior	554693749746V
175	3822	Kelly	Moreira	M	Mocambique	Manica	Nampula	Mocambicana	D	1995-06-09	Laboral	UP-Gurue	Escola Secundária da Maxixe	43	48	Superior	498783191871A
176	3823	Joaquim	Brito	F	Mocambique	Zambézia	Inhambane	Mocambicana	V	2001-01-19	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	61	65	Superior	295201739474V
177	3824	Sara	Teixeira	F	Mocambique	Tete	Nampula	Mocambicana	C	2003-09-21	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	39	50	Superior	007140241828A
178	3825	André	Garcia	F	Mocambique	Cidade de Maputo	Gaza	Mocambicana	D	1999-07-10	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	45	42	Superior	471997239568Z
179	3826	Mia	Vicente	F	Mocambique	Tete	Nampula	Mocambicana	V	1998-06-28	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	37	60	Superior	523735846928I
180	3827	Joaquim	Campos	F	Mocambique	Maputo	Gaza	Mocambicana	C	2003-06-13	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	63	40	Superior	197284212563D
181	3828	Kelly	Pinheiro	M	Mocambique	Tete	Inhambane	Mocambicana	S	1998-03-14	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	64	46	Superior	085617226517Q
182	3829	Vera	Mota	F	Mocambique	Tete	Nampula	Mocambicana	D	1999-04-24	Laboral	UP-Massinga	Colegio Arco-iris	52	56	Superior	998591858619W
183	3830	Joaquim	Andrade	F	Mocambique	Maputo	Zambézia	Mocambicana	C	2002-09-04	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	48	65	Superior	820692707070O
184	3831	Márcio	Amorim	F	Mocambique	Maputo	Tete	Mocambicana	D	2001-04-12	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	37	64	Superior	784616207481W
185	3832	Carolina	Morais	M	Mocambique	Manica	Cabo Delgado	Mocambicana	C	2004-05-08	Laboral	UP-Quelimane	Escola Secundária da Maxixe	41	38	Superior	307611573494G
186	3833	Lúcia	Pinho	M	Mocambique	Nampula	Tete	Mocambicana	D	1998-07-13	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	57	45	Superior	802069708331X
187	3834	Marta	Cunha	F	Mocambique	Nampula	Maputo	Mocambicana	C	2005-08-16	Laboral	UP-Quelimane	Escola Secundária da Maxixe	55	45	Superior	360344320925M
188	3835	Carminho	Henriques	F	Mocambique	Cabo Delgado	Nampula	Mocambicana	V	2004-05-05	Laboral	UP-Quelimane	Colegio Arco-iris	38	61	Superior	440316754372Y
189	3836	Joaquim	Brito	F	Mocambique	Manica	Tete	Mocambicana	S	1995-07-23	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	37	51	Superior	572182026498I
190	3837	Érica	Ferreira	F	Mocambique	Tete	Cidade de Maputo	Mocambicana	S	1998-02-02	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	51	60	Superior	740874694646A
191	3838	Érica	Anjos	F	Mocambique	Zambézia	Nampula	Mocambicana	C	2002-09-30	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	46	47	Superior	911158849467Y
192	3839	Guilherme	Batista	M	Mocambique	Manica	Sofala	Mocambicana	V	2000-05-24	Laboral	UP-Lichinga	Colegio Arco-iris	65	46	Superior	929427620272J
193	3840	Emanuel	Barbosa	F	Mocambique	Manica	Zambézia	Mocambicana	V	1999-11-13	Laboral	UP-Quelimane	Colegio Arco-iris	55	63	Superior	770427846361Y
194	3841	Melissa	Correia	M	Mocambique	Tete	Inhambane	Mocambicana	C	1997-11-22	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	64	43	Superior	258209180231P
195	3842	Lorena	Moura	M	Mocambique	Cabo Delgado	Manica	Mocambicana	C	1998-07-18	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	46	65	Superior	654616492415E
196	3843	Nuno	Miranda	F	Mocambique	Tete	Niassa	Mocambicana	D	2006-05-04	Laboral	UP-Quelimane	Escola Secundária da Maxixe	55	64	Superior	112479955293E
197	3844	Ismael	Ferreira	F	Mocambique	Gaza	Manica	Mocambicana	S	2004-03-11	Laboral	UP-Gurue	Colegio Arco-iris	57	43	Superior	926600855637A
198	3845	Salvador	Campos	M	Mocambique	Manica	Cabo Delgado	Mocambicana	C	1996-08-24	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	43	56	Superior	502763907742X
199	3846	Miguel	Abreu	F	Mocambique	Gaza	Nampula	Mocambicana	S	2005-12-24	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	46	43	Superior	545458628602E
200	3847	André	Valente	M	Mocambique	Sofala	Cidade de Maputo	Mocambicana	S	2000-10-01	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	64	52	Superior	393992682079H
201	3848	Erika	Figueiredo	F	Mocambique	Inhambane	Maputo	Mocambicana	V	1996-12-30	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	36	46	Superior	245810415051Q
202	3849	Teresa	Amaral	M	Mocambique	Nampula	Sofala	Mocambicana	C	2001-09-20	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	60	52	Superior	954398835353N
203	3850	Lisandro	Pires	F	Mocambique	Zambézia	Sofala	Mocambicana	S	1998-04-23	Laboral	UP-Gurue	Escola Secundária da Maxixe	42	37	Superior	172138255220C
204	3851	Bryan	Barbosa	M	Mocambique	Zambézia	Tete	Mocambicana	D	2001-11-10	Laboral	UP-Lichinga	Colegio Arco-iris	66	50	Superior	903293233591H
205	3852	Rafael	Garcia	M	Mocambique	Nampula	Sofala	Mocambicana	D	1999-06-23	Pos-Laboral	UP-Gurue	Colegio Arco-iris	40	45	Superior	735767045461B
206	3853	Beatriz	Magalhães	F	Mocambique	Maputo	Niassa	Mocambicana	D	2006-11-10	Pos-Laboral	UP-Gurue	Colegio Arco-iris	61	42	Superior	455193300232C
207	3854	Fernando	Silva	M	Mocambique	Sofala	Gaza	Mocambicana	S	2004-08-26	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	40	56	Superior	595230418148T
208	3855	Madalena	Miranda	F	Mocambique	Inhambane	Maputo	Mocambicana	D	1996-04-29	Laboral	UP-Gurue	Colegio Arco-iris	54	44	Superior	504527364832E
209	3856	Jaime	Branco	F	Mocambique	Cabo Delgado	Manica	Mocambicana	D	1996-04-14	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	55	42	Superior	543688039272Y
210	3857	Gaspar	Borges	F	Mocambique	Cabo Delgado	Nampula	Mocambicana	S	2006-12-28	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	68	50	Superior	822309275792I
211	3858	Constança	Paiva	F	Mocambique	Tete	Niassa	Mocambicana	C	1998-11-26	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	63	45	Superior	888389567395I
212	3859	Daniela	Rocha	F	Mocambique	Tete	Cabo Delgado	Mocambicana	S	1995-01-11	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	44	65	Superior	810758764262B
213	3860	Leandro	Rocha	F	Mocambique	Cabo Delgado	Cidade de Maputo	Mocambicana	C	2002-05-16	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	49	67	Superior	840515377855B
214	3861	Samuel	Vicente	M	Mocambique	Gaza	Zambézia	Mocambicana	V	2005-12-13	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	66	52	Superior	700642836255V
215	3862	Ricardo	Loureiro	F	Mocambique	Gaza	Maputo	Mocambicana	V	2005-01-27	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	63	56	Superior	711007648330T
216	3863	Mia	Barbosa	M	Mocambique	Niassa	Cidade de Maputo	Mocambicana	C	2001-10-03	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	36	68	Superior	468934753062P
217	3864	Henrique	Leal	M	Mocambique	Manica	Cidade de Maputo	Mocambicana	S	2002-07-07	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	40	45	Superior	311552484906O
218	3865	Tiago	Amorim	F	Mocambique	Cidade de Maputo	Manica	Mocambicana	V	2006-02-27	Laboral	UP-Gurue	Colegio Arco-iris	41	55	Superior	331421546477T
219	3866	Vitória	Carneiro	M	Mocambique	Gaza	Niassa	Mocambicana	S	2001-04-01	Pos-Laboral	UP-Massinga	Colegio Arco-iris	58	68	Superior	770752353811L
220	3867	Rita	Paiva	F	Mocambique	Niassa	Nampula	Mocambicana	S	1996-01-08	Pos-Laboral	UP-Gurue	Colegio Arco-iris	38	51	Superior	884130080136W
221	3868	Paulo	Garcia	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	C	2004-08-14	Laboral	UP-Xai-Xai	Colegio Arco-iris	61	40	Superior	786376205717V
222	3869	Camila	Machado	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	S	1996-07-25	Laboral	UP-Massinga	Escola Secundária da Maxixe	43	66	Superior	412718122802Z
223	3870	Miguel	Mendes	M	Mocambique	Sofala	Maputo	Mocambicana	C	2003-04-04	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	60	58	Superior	547507060980X
224	3871	Mário	Ribeiro	F	Mocambique	Zambézia	Sofala	Mocambicana	C	1996-10-23	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	48	45	Superior	155147293941L
225	3872	Caetana	Leite	M	Mocambique	Cabo Delgado	Nampula	Mocambicana	D	2006-02-21	Pos-Laboral	UP-Gurue	Colegio Arco-iris	65	38	Superior	646374491184Y
226	3873	Gil	Ribeiro	M	Mocambique	Tete	Nampula	Mocambicana	D	1998-07-22	Pos-Laboral	UP-Gurue	Colegio Arco-iris	37	43	Superior	222381617486B
227	3874	Hugo	Lopes	F	Mocambique	Maputo	Nampula	Mocambicana	D	2001-07-08	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	39	50	Superior	449202569244V
228	3875	Joel	Morais	F	Mocambique	Niassa	Tete	Mocambicana	V	2002-05-27	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	51	55	Superior	470927337980L
229	3876	Daniel	Nascimento	F	Mocambique	Cabo Delgado	Niassa	Mocambicana	D	2003-06-24	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	60	57	Superior	844627134735U
230	3877	Xavier	Baptista	F	Mocambique	Zambézia	Maputo	Mocambicana	D	1996-02-02	Laboral	UP-Massinga	Colegio Arco-iris	65	43	Superior	154730740824T
231	3878	Carminho	Garcia	M	Mocambique	Manica	Gaza	Mocambicana	C	2002-12-29	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	60	47	Superior	860293181671U
232	3879	Jaime	Almeida	F	Mocambique	Manica	Cidade de Maputo	Mocambicana	V	1995-11-12	Laboral	UP-Quelimane	Colegio Arco-iris	59	65	Superior	982215878828N
233	3880	Constança	Loureiro	M	Mocambique	Inhambane	Manica	Mocambicana	C	2000-06-08	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	58	62	Superior	445349020292N
234	3881	Henrique	Vieira	F	Mocambique	Nampula	Cabo Delgado	Mocambicana	D	2003-01-13	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	44	43	Superior	855804466398L
235	3882	Vera	Batista	M	Mocambique	Gaza	Zambézia	Mocambicana	S	1995-07-16	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	57	65	Superior	443301042863B
236	3883	Gustavo	Pires	M	Mocambique	Inhambane	Inhambane	Mocambicana	D	1996-03-26	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	52	37	Superior	791073417946T
237	3884	Nelson	Miranda	M	Mocambique	Tete	Tete	Mocambicana	D	1995-07-17	Laboral	UP-Xai-Xai	Colegio Arco-iris	50	48	Superior	120893019053X
238	3885	Samuel	Reis	F	Mocambique	Inhambane	Gaza	Mocambicana	V	1995-07-15	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	47	67	Superior	464697441931T
239	3886	Guilherme	Ribeiro	F	Mocambique	Cidade de Maputo	Zambézia	Mocambicana	D	2003-05-07	Laboral	UP-Quelimane	Escola Secundária da Maxixe	37	62	Superior	264881879556N
240	3887	David	Faria	F	Mocambique	Cidade de Maputo	Cabo Delgado	Mocambicana	V	2003-07-17	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	42	51	Superior	683693378550T
241	3888	Gabriela	Castro	M	Mocambique	Gaza	Cidade de Maputo	Mocambicana	D	2005-10-01	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	67	35	Superior	969606309222R
242	3889	Madalena	Barbosa	M	Mocambique	Manica	Maputo	Mocambicana	S	1997-04-25	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	56	61	Superior	581095378870G
243	3890	Lisandro	Henriques	M	Mocambique	Zambézia	Zambézia	Mocambicana	V	2003-01-31	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	53	66	Superior	411853376892L
244	3891	Bernardo	Gaspar	M	Mocambique	Maputo	Gaza	Mocambicana	D	2005-09-13	Laboral	UP-Xai-Xai	Colegio Arco-iris	47	65	Superior	894223503824Z
245	3892	Vítor	Fernandes	F	Mocambique	Sofala	Niassa	Mocambicana	S	1998-07-08	Pos-Laboral	UP-Massinga	Colegio Arco-iris	38	64	Superior	828614929549Z
246	3893	Guilherme	Barros	F	Mocambique	Tete	Cidade de Maputo	Mocambicana	D	2002-02-11	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	46	44	Superior	227655669669U
247	3894	Andreia	Ribeiro	F	Mocambique	Zambézia	Gaza	Mocambicana	S	1996-07-11	Laboral	UP-Gurue	Escola Secundária da Maxixe	68	65	Superior	946887974874W
248	3895	Noa	Araújo	F	Mocambique	Cidade de Maputo	Zambézia	Mocambicana	S	2003-02-21	Laboral	UP-Lichinga	Colegio Arco-iris	66	65	Superior	819577632699H
249	3896	David	Almeida	M	Mocambique	Tete	Cabo Delgado	Mocambicana	D	1995-04-16	Laboral	UP-Gurue	Escola Secundária da Maxixe	48	49	Superior	281297811481V
250	3897	Gabriel	Abreu	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	V	2006-06-29	Laboral	UP-Lichinga	Colegio Arco-iris	66	53	Superior	440743591049D
251	3898	Jorge	Mota	F	Mocambique	Inhambane	Tete	Mocambicana	S	1999-03-10	Laboral	UP-Massinga	Colegio Arco-iris	67	54	Superior	913585789172R
252	3899	Andreia	Gaspar	F	Mocambique	Sofala	Cabo Delgado	Mocambicana	V	1999-07-05	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	64	54	Superior	494492798274U
253	3900	Salomé	Assunção	F	Mocambique	Nampula	Maputo	Mocambicana	D	2002-11-16	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	51	66	Superior	050748360847R
254	3901	Luna	Pinho	F	Mocambique	Gaza	Niassa	Mocambicana	D	2000-09-20	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	48	44	Superior	219954027612L
255	3902	Vasco	Borges	M	Mocambique	Cidade de Maputo	Gaza	Mocambicana	V	2005-05-05	Laboral	UP-Gurue	Colegio Arco-iris	65	61	Superior	258161764868G
256	3903	Emanuel	Moreira	F	Mocambique	Cidade de Maputo	Manica	Mocambicana	S	2000-12-05	Laboral	UP-Xai-Xai	Colegio Arco-iris	40	55	Superior	365292550766Q
257	3904	Sérgio	Morais	F	Mocambique	Tete	Gaza	Mocambicana	V	1998-11-23	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	61	58	Superior	391760487902H
258	3905	Alexandra	Guerreiro	M	Mocambique	Sofala	Zambézia	Mocambicana	C	2006-07-04	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	68	47	Superior	750451987517X
259	3906	Gonçalo	Machado	F	Mocambique	Cabo Delgado	Cidade de Maputo	Mocambicana	D	1997-06-23	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	64	44	Superior	622307843419S
260	3907	Carolina	Branco	F	Mocambique	Tete	Zambézia	Mocambicana	C	1995-07-10	Laboral	UP-Massinga	Colegio Arco-iris	56	37	Superior	151380842750K
261	3908	Lia	Nascimento	M	Mocambique	Sofala	Tete	Mocambicana	C	2004-12-15	Laboral	UP-Quelimane	Escola Secundária da Maxixe	48	54	Superior	773996351202T
262	3909	Carlos	Amorim	F	Mocambique	Inhambane	Manica	Mocambicana	V	2004-04-01	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	54	49	Superior	378747903764X
263	3910	Ângela	Reis	M	Mocambique	Sofala	Inhambane	Mocambicana	S	1997-11-23	Laboral	UP-Xai-Xai	Colegio Arco-iris	48	47	Superior	835385467928S
264	3911	Sebastião	Barbosa	M	Mocambique	Cidade de Maputo	Niassa	Mocambicana	V	2001-09-11	Pos-Laboral	UP-Massinga	Colegio Arco-iris	67	42	Superior	466891210700T
265	3912	Constança	Assunção	M	Mocambique	Nampula	Cidade de Maputo	Mocambicana	C	1996-05-04	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	49	46	Superior	944784887354R
266	3913	Filipa	Abreu	F	Mocambique	Nampula	Manica	Mocambicana	D	1998-12-08	Laboral	UP-Lichinga	Escola Secundária da Maxixe	60	53	Superior	155979268685A
267	3914	Pilar	Azevedo	M	Mocambique	Maputo	Nampula	Mocambicana	S	2002-12-09	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	65	49	Superior	346789305382C
268	3915	Martim	Jesus	M	Mocambique	Tete	Manica	Mocambicana	S	2001-11-22	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	48	57	Superior	273240218508T
269	3916	Artur	Mota	M	Mocambique	Niassa	Zambézia	Mocambicana	V	1997-12-26	Laboral	UP-Lichinga	Escola Secundária da Maxixe	39	64	Superior	196393311724K
270	3917	Mateus	Pires	F	Mocambique	Inhambane	Cidade de Maputo	Mocambicana	D	2005-12-27	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	60	63	Superior	692885371701D
271	3918	Rúben	Anjos	F	Mocambique	Cabo Delgado	Sofala	Mocambicana	C	2006-07-16	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	46	68	Superior	138035060953T
272	3919	Naiara	Mendes	M	Mocambique	Niassa	Inhambane	Mocambicana	S	1997-10-05	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	45	48	Superior	380800262593L
273	3920	Teresa	Pires	M	Mocambique	Niassa	Niassa	Mocambicana	D	2006-02-09	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	50	67	Superior	570987220211B
274	3921	Gonçalo	Loureiro	F	Mocambique	Sofala	Sofala	Mocambicana	D	1995-02-27	Laboral	UP-Quelimane	Colegio Arco-iris	35	39	Superior	259556031209B
275	3922	Luana	Tavares	M	Mocambique	Cidade de Maputo	Nampula	Mocambicana	D	2004-10-25	Laboral	UP-Massinga	Colegio Arco-iris	62	52	Superior	262113869407G
276	3923	Mauro	Esteves	F	Mocambique	Niassa	Gaza	Mocambicana	C	1996-03-09	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	36	38	Superior	699697380079M
277	3924	João	Neves	M	Mocambique	Maputo	Maputo	Mocambicana	C	2002-03-25	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	62	54	Superior	014897261498M
278	3925	Bruna	Andrade	M	Mocambique	Nampula	Maputo	Mocambicana	S	2005-11-08	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	53	50	Superior	085772287544I
279	3926	Ivan	Andrade	M	Mocambique	Manica	Manica	Mocambicana	S	2002-10-10	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	47	52	Superior	246789914518N
280	3927	Gonçalo	Vieira	M	Mocambique	Nampula	Gaza	Mocambicana	D	1998-10-15	Pos-Laboral	UP-Massinga	Colegio Arco-iris	37	50	Superior	084661799381H
281	3928	Manuel	Miranda	M	Mocambique	Maputo	Sofala	Mocambicana	V	1995-01-07	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	54	46	Superior	228546869445R
282	3929	Jaime	Sá	M	Mocambique	Maputo	Sofala	Mocambicana	S	2002-02-08	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	68	58	Superior	233815905275Y
283	3930	Fabiana	Freitas	M	Mocambique	Cidade de Maputo	Tete	Mocambicana	S	1999-03-10	Laboral	UP-Massinga	Escola Secundária da Maxixe	47	50	Superior	486984791536G
284	3931	Bernardo	Vicente	F	Mocambique	Cabo Delgado	Cidade de Maputo	Mocambicana	C	2004-11-07	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	43	65	Superior	839512871075A
285	3932	Bruno	Lima	F	Mocambique	Inhambane	Sofala	Mocambicana	C	1995-08-14	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	53	47	Superior	577480584714Y
286	3933	Adriana	Simões	M	Mocambique	Maputo	Nampula	Mocambicana	V	2005-08-01	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	36	46	Superior	231876405481L
287	3934	Eduardo	Borges	M	Mocambique	Maputo	Niassa	Mocambicana	D	2003-01-04	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	39	62	Superior	866408791387V
288	3935	Lourenço	Antunes	M	Mocambique	Nampula	Gaza	Mocambicana	V	1998-01-08	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	55	61	Superior	293857687658Q
289	3936	Lúcia	Leite	F	Mocambique	Tete	Tete	Mocambicana	S	2006-03-13	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	56	53	Superior	374609498699N
290	3937	Madalena	Pinheiro	F	Mocambique	Inhambane	Manica	Mocambicana	D	1999-08-01	Laboral	UP-Xai-Xai	Colegio Arco-iris	58	40	Superior	324696514234K
291	3938	Caetana	Baptista	F	Mocambique	Cabo Delgado	Cidade de Maputo	Mocambicana	V	2004-02-16	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	68	62	Superior	985320545622X
292	3939	Sérgio	Coelho	F	Mocambique	Gaza	Maputo	Mocambicana	V	2000-09-22	Laboral	UP-Lichinga	Colegio Arco-iris	47	53	Superior	485407455258F
293	3940	Simão	Miranda	M	Mocambique	Maputo	Gaza	Mocambicana	V	2002-03-22	Laboral	UP-Xai-Xai	Colegio Arco-iris	52	53	Superior	934915605476U
294	3941	Mara	Silva	M	Mocambique	Zambézia	Nampula	Mocambicana	V	1995-10-10	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	54	49	Superior	376187200869R
295	3942	Cristiano	Morais	F	Mocambique	Gaza	Tete	Mocambicana	C	1997-02-17	Laboral	UP-Gurue	Colegio Arco-iris	40	51	Superior	358742275571C
296	3943	Marcos	Cunha	M	Mocambique	Nampula	Zambézia	Mocambicana	D	1998-01-10	Laboral	UP-Lichinga	Escola Secundária da Maxixe	38	59	Superior	005633324415V
297	3944	César	Campos	F	Mocambique	Gaza	Tete	Mocambicana	C	1996-04-30	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	51	35	Superior	246947310924J
298	3945	Raquel	Neves	M	Mocambique	Nampula	Cidade de Maputo	Mocambicana	D	2000-03-01	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	55	43	Superior	888075758204U
299	3946	Luca	Abreu	M	Mocambique	Manica	Maputo	Mocambicana	C	1999-08-25	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	67	55	Superior	132856113394X
300	3947	Ivan	Anjos	F	Mocambique	Cidade de Maputo	Inhambane	Mocambicana	D	1998-01-02	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	52	53	Superior	052959858475Q
301	3948	Mélanie	Guerreiro	M	Mocambique	Niassa	Cidade de Maputo	Mocambicana	S	2001-12-03	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	57	45	Superior	972873292921S
302	3949	Miriam	Almeida	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	C	2004-07-28	Laboral	UP-Lichinga	Colegio Arco-iris	46	38	Superior	647533810507F
303	3950	Pedro	Cunha	M	Mocambique	Gaza	Manica	Mocambicana	C	2006-04-05	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	59	67	Superior	654383847167L
304	3951	Denis	Sá	M	Mocambique	Sofala	Inhambane	Mocambicana	V	2000-06-27	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	67	68	Superior	669324219044G
305	3952	Mário	Garcia	F	Mocambique	Inhambane	Maputo	Mocambicana	S	2006-04-16	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	64	57	Superior	340125069029U
306	3953	Carlos	Brito	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	V	1998-06-26	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	62	68	Superior	975596162967U
307	3954	Simão	Cruz	M	Mocambique	Cabo Delgado	Niassa	Mocambicana	V	1996-03-19	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	56	67	Superior	205868844898R
308	3955	Rafaela	Nascimento	M	Mocambique	Tete	Manica	Mocambicana	V	2001-04-11	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	59	55	Superior	666362432134U
309	3956	Melissa	Moura	M	Mocambique	Tete	Zambézia	Mocambicana	C	1997-06-16	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	59	38	Superior	407305179430R
310	3957	Nádia	Martins	M	Mocambique	Maputo	Tete	Mocambicana	V	2001-11-02	Laboral	UP-Gurue	Escola Secundária da Maxixe	65	44	Superior	589473052620X
311	3958	Carlota	Amaral	M	Mocambique	Nampula	Cabo Delgado	Mocambicana	V	2000-11-19	Laboral	UP-Gurue	Colegio Arco-iris	67	53	Superior	220575625981V
312	3959	Inês	Torres	M	Mocambique	Niassa	Gaza	Mocambicana	V	1996-12-25	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	59	48	Superior	602390866166F
313	3960	Marco	Moreira	F	Mocambique	Inhambane	Tete	Mocambicana	S	1999-05-21	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	62	52	Superior	208229457346Y
314	3961	Fernando	Lourenço	M	Mocambique	Cabo Delgado	Tete	Mocambicana	D	1999-12-02	Laboral	UP-Gurue	Colegio Arco-iris	60	55	Superior	932249366412V
315	3962	Érica	Ribeiro	M	Mocambique	Tete	Niassa	Mocambicana	D	2004-04-13	Laboral	UP-Massinga	Escola Secundária da Maxixe	63	41	Superior	157429510881T
316	3963	Enzo	Santos	F	Mocambique	Tete	Zambézia	Mocambicana	S	2002-04-02	Laboral	UP-Xai-Xai	Colegio Arco-iris	63	60	Superior	231575743589B
317	3964	Amélia	Vicente	F	Mocambique	Inhambane	Sofala	Mocambicana	D	2004-11-14	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	65	45	Superior	105435059270A
318	3965	Bruna	Lourenço	F	Mocambique	Maputo	Tete	Mocambicana	C	1996-09-14	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	44	48	Superior	805341026682C
319	3966	Diogo	Neto	M	Mocambique	Tete	Zambézia	Mocambicana	V	1998-07-30	Laboral	UP-Lichinga	Colegio Arco-iris	41	59	Superior	458666102713T
320	3967	Sérgio	Fonseca	F	Mocambique	Zambézia	Cidade de Maputo	Mocambicana	V	2001-08-05	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	47	37	Superior	693396913049W
321	3968	Ivo	Morais	F	Mocambique	Sofala	Gaza	Mocambicana	C	2004-05-01	Laboral	UP-Massinga	Colegio Arco-iris	45	66	Superior	675827272565M
322	3969	Brian	Macedo	M	Mocambique	Nampula	Cidade de Maputo	Mocambicana	V	1997-09-22	Laboral	UP-Quelimane	Colegio Arco-iris	65	61	Superior	740237784713L
323	3970	Melissa	Melo	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	D	1996-09-22	Laboral	UP-Quelimane	Colegio Arco-iris	68	64	Superior	805091517313M
324	3971	Enzo	Ferreira	F	Mocambique	Sofala	Cabo Delgado	Mocambicana	C	1996-07-20	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	38	59	Superior	583255544533K
325	3972	Sofia	Brito	F	Mocambique	Manica	Inhambane	Mocambicana	D	2003-08-05	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	55	67	Superior	937083728785R
326	3973	Mafalda	Monteiro	F	Mocambique	Sofala	Nampula	Mocambicana	D	2000-07-15	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	49	66	Superior	421351821012P
327	3974	Isaac	Lourenço	M	Mocambique	Sofala	Nampula	Mocambicana	C	2000-01-15	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	47	40	Superior	251559037535R
328	3975	Joaquim	Reis	M	Mocambique	Manica	Tete	Mocambicana	C	2006-08-13	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	41	38	Superior	180150556236T
329	3976	Wilson	Magalhães	M	Mocambique	Inhambane	Nampula	Mocambicana	S	2000-04-21	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	51	63	Superior	922185048504R
330	3977	Guilherme	Loureiro	M	Mocambique	Niassa	Niassa	Mocambicana	C	1999-10-05	Laboral	UP-Gurue	Colegio Arco-iris	44	68	Superior	338146254257Q
331	3978	Mateus	Maia	F	Mocambique	Sofala	Inhambane	Mocambicana	V	1998-12-27	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	64	37	Superior	034861143371R
332	3979	Juliana	Antunes	F	Mocambique	Manica	Niassa	Mocambicana	C	2001-01-12	Laboral	UP-Quelimane	Colegio Arco-iris	58	41	Superior	518493670343Z
333	3980	Ivo	Pinho	M	Mocambique	Sofala	Tete	Mocambicana	C	1998-04-29	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	63	38	Superior	291509803664B
334	3981	Gil	Macedo	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	D	2004-05-19	Laboral	UP-Quelimane	Colegio Arco-iris	66	50	Superior	426404742128L
335	3982	Margarida	Borges	F	Mocambique	Tete	Cidade de Maputo	Mocambicana	D	1996-09-03	Laboral	UP-Quelimane	Colegio Arco-iris	49	57	Superior	970562567546C
336	3983	Ângelo	Morais	F	Mocambique	Cidade de Maputo	Zambézia	Mocambicana	C	2006-11-14	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	61	48	Superior	946957439255N
337	3984	Miriam	Vieira	M	Mocambique	Zambézia	Cabo Delgado	Mocambicana	C	2005-06-17	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	64	41	Superior	718138071259E
338	3985	Mariana	Martins	F	Mocambique	Maputo	Maputo	Mocambicana	S	1999-07-29	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	41	56	Superior	576804867855I
339	3986	Flor	Azevedo	M	Mocambique	Sofala	Maputo	Mocambicana	C	1997-09-28	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	67	48	Superior	680750381045J
340	3987	Gustavo	Loureiro	M	Mocambique	Niassa	Niassa	Mocambicana	S	2003-08-30	Laboral	UP-Massinga	Escola Secundária da Maxixe	53	51	Superior	781578348750G
341	3988	Bruno	Araújo	F	Mocambique	Inhambane	Gaza	Mocambicana	C	2000-04-11	Pos-Laboral	UP-Massinga	Colegio Arco-iris	44	41	Superior	875935741115B
342	3989	Laura	Azevedo	M	Mocambique	Inhambane	Maputo	Mocambicana	D	2004-09-16	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	54	62	Superior	281201934488U
343	3990	César	Barbosa	M	Mocambique	Tete	Zambézia	Mocambicana	S	1999-08-26	Laboral	UP-Lichinga	Escola Secundária da Maxixe	38	49	Superior	159524662707O
344	3991	Bruno	Amaral	M	Mocambique	Sofala	Manica	Mocambicana	C	1998-04-15	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	50	49	Superior	871406813699N
345	3992	Noa	Ferreira	M	Mocambique	Inhambane	Sofala	Mocambicana	C	1998-06-27	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	53	52	Superior	219684019425C
346	3993	Jorge	Araújo	F	Mocambique	Sofala	Nampula	Mocambicana	V	2003-01-29	Laboral	UP-Xai-Xai	Colegio Arco-iris	60	67	Superior	865723995136X
347	3994	Bianca	Branco	F	Mocambique	Sofala	Sofala	Mocambicana	V	2000-10-05	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	61	47	Superior	590219355224O
348	3995	João	Cardoso	M	Mocambique	Manica	Gaza	Mocambicana	D	1999-02-26	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	47	43	Superior	931204694135W
349	3996	Filipe	Pinho	F	Mocambique	Cabo Delgado	Manica	Mocambicana	D	2005-02-18	Laboral	UP-Gurue	Colegio Arco-iris	44	56	Superior	023866748556Q
350	3997	Luana	Esteves	M	Mocambique	Manica	Nampula	Mocambicana	D	2001-11-11	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	66	52	Superior	953114619713T
351	3998	Edgar	Leite	F	Mocambique	Manica	Niassa	Mocambicana	C	1999-12-27	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	52	53	Superior	970735885102O
352	3999	Alice	Monteiro	M	Mocambique	Inhambane	Zambézia	Mocambicana	D	1996-07-06	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	67	54	Superior	020229654766D
353	4000	Ana	Azevedo	F	Mocambique	Inhambane	Sofala	Mocambicana	S	1999-02-14	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	57	35	Superior	739498549936A
354	4001	Ana	Assunção	F	Mocambique	Maputo	Niassa	Mocambicana	S	2003-02-27	Laboral	UP-Quelimane	Escola Secundária da Maxixe	57	67	Superior	007356231668L
355	4002	Gustavo	Amorim	F	Mocambique	Cidade de Maputo	Tete	Mocambicana	V	2000-06-23	Laboral	UP-Quelimane	Escola Secundária da Maxixe	46	67	Superior	580185968649B
356	4003	Inês	Simões	M	Mocambique	Sofala	Manica	Mocambicana	V	2003-10-25	Pos-Laboral	UP-Massinga	Colegio Arco-iris	62	44	Superior	446218358160C
357	4004	Artur	Lima	M	Mocambique	Sofala	Niassa	Mocambicana	C	1995-07-19	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	51	59	Superior	315054363258P
358	4005	Madalena	Melo	F	Mocambique	Maputo	Tete	Mocambicana	V	2000-01-18	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	50	53	Superior	288872924149V
359	4006	Diego	Tavares	F	Mocambique	Maputo	Manica	Mocambicana	C	1996-03-21	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	38	55	Superior	997526474454I
360	4007	Ângela	Pereira	M	Mocambique	Cabo Delgado	Manica	Mocambicana	V	1998-08-12	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	35	60	Superior	539641358281Q
361	4008	Joaquim	Domingues	F	Mocambique	Maputo	Zambézia	Mocambicana	S	1999-03-07	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	63	48	Superior	668725572166W
362	4009	Cristiano	Vaz	M	Mocambique	Sofala	Cidade de Maputo	Mocambicana	V	2005-05-02	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	40	48	Superior	533427090865E
363	4010	César	Abreu	M	Mocambique	Nampula	Zambézia	Mocambicana	S	2001-12-29	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	38	54	Superior	799795690917T
364	4011	William	Matos	M	Mocambique	Niassa	Nampula	Mocambicana	C	1996-04-10	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	58	62	Superior	185595511978V
365	4012	Érica	Morais	F	Mocambique	Tete	Tete	Mocambicana	D	1996-06-08	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	54	47	Superior	412733867134W
366	4013	Marcos	Carneiro	M	Mocambique	Manica	Niassa	Mocambicana	S	2004-06-20	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	57	44	Superior	762908647090R
367	4014	Jorge	Faria	M	Mocambique	Cabo Delgado	Nampula	Mocambicana	C	1997-10-19	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	61	47	Superior	626082659145N
368	4015	Eduarda	Moreira	F	Mocambique	Zambézia	Manica	Mocambicana	S	1996-12-06	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	46	36	Superior	857731100946P
369	4016	Mia	Cunha	M	Mocambique	Niassa	Zambézia	Mocambicana	V	1998-01-17	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	41	37	Superior	680607249506Z
370	4017	Benedita	Cruz	M	Mocambique	Tete	Maputo	Mocambicana	V	2005-08-08	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	57	42	Superior	802173771066J
371	4018	Ema	Pinheiro	M	Mocambique	Cidade de Maputo	Inhambane	Mocambicana	S	1998-06-23	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	65	35	Superior	203003384254G
372	4019	Kevin	Soares	M	Mocambique	Niassa	Maputo	Mocambicana	S	1996-09-15	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	45	62	Superior	679232479539V
373	4020	Carminho	Mota	F	Mocambique	Gaza	Zambézia	Mocambicana	D	2002-06-17	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	40	61	Superior	832550111456O
374	4021	William	Figueiredo	M	Mocambique	Cabo Delgado	Tete	Mocambicana	V	2000-12-10	Laboral	UP-Gurue	Escola Secundária da Maxixe	52	59	Superior	580757725135W
375	4022	Naiara	Esteves	F	Mocambique	Cidade de Maputo	Cidade de Maputo	Mocambicana	D	1995-06-04	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	67	41	Superior	531547557057P
376	4023	Ivan	Leal	M	Mocambique	Nampula	Sofala	Mocambicana	V	2006-02-25	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	50	52	Superior	327624263608Q
377	4024	Rui	Assunção	F	Mocambique	Nampula	Sofala	Mocambicana	D	2005-05-20	Laboral	UP-Massinga	Escola Secundária da Maxixe	37	54	Superior	606152225184Q
378	4025	Xavier	Brito	F	Mocambique	Maputo	Sofala	Mocambicana	S	1995-08-16	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	47	60	Superior	087219562396E
379	4026	Salvador	Morais	F	Mocambique	Niassa	Tete	Mocambicana	D	1995-11-02	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	39	65	Superior	510529026178Z
380	4027	Sérgio	Garcia	M	Mocambique	Cidade de Maputo	Nampula	Mocambicana	D	1995-02-15	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	65	36	Superior	948235170967E
381	4028	David	Domingues	M	Mocambique	Inhambane	Zambézia	Mocambicana	V	2001-07-01	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	42	68	Superior	329594990180K
382	4029	Luana	Barbosa	M	Mocambique	Zambézia	Sofala	Mocambicana	D	1999-06-29	Laboral	UP-Xai-Xai	Colegio Arco-iris	35	56	Superior	486307419348T
383	4030	Kelly	Nascimento	F	Mocambique	Maputo	Gaza	Mocambicana	V	2001-05-09	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	36	41	Superior	573874975589V
384	4031	Rui	Guerreiro	F	Mocambique	Manica	Cidade de Maputo	Mocambicana	S	1996-10-22	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	52	39	Superior	010923748192N
385	4032	Erica	Magalhães	M	Mocambique	Zambézia	Inhambane	Mocambicana	C	1996-11-25	Laboral	UP-Massinga	Colegio Arco-iris	35	59	Superior	372225333390Z
386	4033	Bryan	Moura	F	Mocambique	Zambézia	Gaza	Mocambicana	C	2004-06-08	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	50	43	Superior	416865666234W
387	4034	Tiago	Vieira	F	Mocambique	Manica	Inhambane	Mocambicana	D	1998-08-20	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	67	41	Superior	290512824093R
388	4035	Camila	Cruz	M	Mocambique	Gaza	Cidade de Maputo	Mocambicana	D	2005-05-31	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	66	38	Superior	892812525848F
389	4036	Tomé	Neves	F	Mocambique	Cabo Delgado	Inhambane	Mocambicana	V	1997-04-19	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	42	44	Superior	465922486161R
390	4037	António	Garcia	F	Mocambique	Niassa	Nampula	Mocambicana	S	2003-01-26	Laboral	UP-Lichinga	Escola Secundária da Maxixe	56	39	Superior	433036167081S
391	4038	Leonor	Ferreira	F	Mocambique	Maputo	Maputo	Mocambicana	V	2000-07-22	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	39	51	Superior	836396670710G
392	4039	Tomás	Guerreiro	F	Mocambique	Tete	Sofala	Mocambicana	C	1996-08-23	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	50	68	Superior	389771397336R
393	4040	Joana	Leite	M	Mocambique	Sofala	Cidade de Maputo	Mocambicana	C	1995-03-24	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	64	36	Superior	244778312467P
394	4041	Emma	Rocha	M	Mocambique	Zambézia	Niassa	Mocambicana	C	2005-02-08	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	50	57	Superior	091168552828L
395	4042	Leonardo	Campos	M	Mocambique	Sofala	Nampula	Mocambicana	S	2003-10-23	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	54	44	Superior	002755338204R
396	4043	Soraia	Teixeira	M	Mocambique	Niassa	Nampula	Mocambicana	C	1996-02-05	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	43	48	Superior	906496343833J
397	4044	Renato	Reis	F	Mocambique	Zambézia	Tete	Mocambicana	D	1995-08-20	Laboral	UP-Gurue	Colegio Arco-iris	65	38	Superior	347242164995K
398	4045	Pedro	Vaz	F	Mocambique	Manica	Maputo	Mocambicana	S	1997-01-08	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	51	57	Superior	442508384443N
399	4046	Carminho	Garcia	F	Mocambique	Zambézia	Cidade de Maputo	Mocambicana	V	2006-11-11	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	42	50	Superior	748504241814P
400	4047	Lara	Coelho	M	Mocambique	Manica	Maputo	Mocambicana	C	2001-09-08	Laboral	UP-Xai-Xai	Colegio Arco-iris	67	35	Superior	114061418130V
401	4048	Petra	Vieira	M	Mocambique	Sofala	Niassa	Mocambicana	S	1999-04-08	Laboral	UP-Xai-Xai	Colegio Arco-iris	50	41	Superior	235370994205O
402	4049	Kyara	Marques	M	Mocambique	Tete	Zambézia	Mocambicana	S	2000-07-21	Laboral	UP-Massinga	Colegio Arco-iris	64	63	Superior	575354088969T
403	4050	Tatiana	Pinto	M	Mocambique	Sofala	Tete	Mocambicana	V	2006-01-23	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	49	68	Superior	061341726325A
404	4051	Marcos	Rocha	F	Mocambique	Maputo	Zambézia	Mocambicana	D	2000-08-10	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	41	42	Superior	855924922198Q
405	4052	Anita	Vieira	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	S	1996-05-03	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	37	38	Superior	428939540264C
406	4053	Benjamim	Magalhães	F	Mocambique	Zambézia	Inhambane	Mocambicana	C	2001-01-01	Laboral	UP-Quelimane	Colegio Arco-iris	65	49	Superior	848026140155T
407	4054	Leonardo	Machado	M	Mocambique	Cabo Delgado	Niassa	Mocambicana	S	1999-05-29	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	53	63	Superior	211600190280M
408	4055	Xavier	Fernandes	F	Mocambique	Zambézia	Maputo	Mocambicana	S	2002-06-13	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	52	38	Superior	595145768740G
409	4056	Andreia	Martins	M	Mocambique	Nampula	Inhambane	Mocambicana	V	2000-06-09	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	37	49	Superior	545393635904G
410	4057	Soraia	Carvalho	M	Mocambique	Niassa	Cidade de Maputo	Mocambicana	D	2002-01-16	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	68	40	Superior	961551533901I
411	4058	Emília	Costa	F	Mocambique	Gaza	Zambézia	Mocambicana	D	1996-08-22	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	51	66	Superior	741145556961J
412	4059	Carlota	Esteves	F	Mocambique	Maputo	Maputo	Mocambicana	C	2004-06-04	Laboral	UP-Gurue	Colegio Arco-iris	39	38	Superior	847639473882R
413	4060	Tomás	Rocha	F	Mocambique	Gaza	Manica	Mocambicana	S	2005-04-20	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	53	66	Superior	657760460820S
414	4061	William	Baptista	F	Mocambique	Sofala	Maputo	Mocambicana	V	1999-10-30	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	46	52	Superior	817382300173A
415	4062	Lia	Magalhães	M	Mocambique	Cidade de Maputo	Inhambane	Mocambicana	V	2000-07-04	Laboral	UP-Quelimane	Colegio Arco-iris	37	35	Superior	430949965076S
416	4063	Anita	Barros	F	Mocambique	Nampula	Niassa	Mocambicana	V	1996-02-26	Laboral	UP-Massinga	Colegio Arco-iris	56	54	Superior	498418462176B
417	4064	Alexandre	Oliveira	F	Mocambique	Gaza	Maputo	Mocambicana	V	2006-07-08	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	57	51	Superior	341734152295S
418	4065	Mateus	Magalhães	F	Mocambique	Niassa	Zambézia	Mocambicana	S	2004-01-25	Pos-Laboral	UP-Massinga	Colegio Arco-iris	48	47	Superior	240774968737K
419	4066	Samuel	Pereira	F	Mocambique	Maputo	Maputo	Mocambicana	D	2002-11-30	Laboral	UP-Gurue	Escola Secundária da Maxixe	45	36	Superior	728460348867L
420	4067	Teresa	Fonseca	F	Mocambique	Niassa	Inhambane	Mocambicana	C	2002-05-30	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	35	39	Superior	215388006365G
421	4068	Luca	Vieira	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	S	1999-04-04	Laboral	UP-Quelimane	Colegio Arco-iris	45	35	Superior	206945965995W
422	4069	Leonardo	Lima	F	Mocambique	Maputo	Manica	Mocambicana	V	2000-11-29	Laboral	UP-Gurue	Escola Secundária da Maxixe	68	66	Superior	235380750815W
423	4070	Afonso	Mendes	M	Mocambique	Tete	Niassa	Mocambicana	V	1999-11-13	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	57	50	Superior	909854023893Q
424	4071	Catarina	Leal	M	Mocambique	Cabo Delgado	Maputo	Mocambicana	S	2003-12-21	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	52	39	Superior	447991155583F
425	4072	Catarina	Azevedo	M	Mocambique	Tete	Cidade de Maputo	Mocambicana	D	1998-05-24	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	40	53	Superior	795795818528T
426	4073	Rafaela	Barbosa	M	Mocambique	Inhambane	Manica	Mocambicana	S	1998-03-25	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	40	54	Superior	777357157817E
427	4074	Pilar	Silva	F	Mocambique	Gaza	Nampula	Mocambicana	C	1998-08-11	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	55	36	Superior	436391569205N
428	4075	Erika	Monteiro	F	Mocambique	Inhambane	Sofala	Mocambicana	C	1998-12-12	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	65	64	Superior	561547991794T
429	4076	William	Vicente	F	Mocambique	Gaza	Tete	Mocambicana	S	2003-04-02	Laboral	UP-Quelimane	Escola Secundária da Maxixe	64	46	Superior	734162466314I
430	4077	Joaquim	Henriques	M	Mocambique	Manica	Nampula	Mocambicana	S	2003-02-04	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	42	54	Superior	676682855772K
431	4078	Mateus	Pinho	F	Mocambique	Cabo Delgado	Tete	Mocambicana	D	1996-08-29	Laboral	UP-Massinga	Escola Secundária da Maxixe	52	48	Superior	519128645688D
432	4079	Tatiana	Magalhães	F	Mocambique	Sofala	Zambézia	Mocambicana	S	2001-07-16	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	60	54	Superior	873442203568P
433	4080	Manuel	Lima	M	Mocambique	Maputo	Gaza	Mocambicana	C	1998-01-17	Laboral	UP-Quelimane	Escola Secundária da Maxixe	46	63	Superior	392768770825J
434	4081	Sofia	Barbosa	M	Mocambique	Cidade de Maputo	Manica	Mocambicana	C	2001-12-09	Laboral	UP-Lichinga	Colegio Arco-iris	68	49	Superior	631532490989W
435	4082	Yara	Mota	M	Mocambique	Maputo	Inhambane	Mocambicana	D	1998-12-17	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	68	35	Superior	338747952424K
436	4083	Diana	Loureiro	M	Mocambique	Cabo Delgado	Zambézia	Mocambicana	D	2003-06-16	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	41	56	Superior	709243108499Y
437	4084	Isaac	Amaral	M	Mocambique	Maputo	Niassa	Mocambicana	S	1999-04-28	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	43	68	Superior	751298978925V
438	4085	Álvaro	Martins	F	Mocambique	Gaza	Zambézia	Mocambicana	C	1996-03-07	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	55	50	Superior	292014835722U
439	4086	Victória	Freitas	M	Mocambique	Tete	Sofala	Mocambicana	C	2003-06-24	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	43	39	Superior	781997721807Q
440	4087	Ivo	Moura	M	Mocambique	Sofala	Maputo	Mocambicana	D	2004-03-25	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	41	64	Superior	263016639178J
441	4088	Luísa	Nunes	M	Mocambique	Gaza	Nampula	Mocambicana	V	2000-09-09	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	52	38	Superior	928871079599F
442	4089	Ricardo	Nascimento	M	Mocambique	Zambézia	Sofala	Mocambicana	S	2001-12-25	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	36	58	Superior	687492044035E
443	4090	Eduarda	Azevedo	F	Mocambique	Manica	Tete	Mocambicana	C	2006-10-12	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	39	50	Superior	052739199446U
444	4091	Leandro	Machado	M	Mocambique	Niassa	Tete	Mocambicana	V	2004-06-18	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	47	66	Superior	380721514550S
445	4092	Irina	Nunes	M	Mocambique	Zambézia	Gaza	Mocambicana	D	2006-02-03	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	50	68	Superior	758961602122E
446	4093	Santiago	Almeida	M	Mocambique	Nampula	Gaza	Mocambicana	S	1996-09-30	Laboral	UP-Gurue	Colegio Arco-iris	48	59	Superior	008680042471S
447	4094	Nelson	Figueiredo	F	Mocambique	Zambézia	Inhambane	Mocambicana	D	2005-08-29	Laboral	UP-Gurue	Escola Secundária da Maxixe	68	45	Superior	822922816162F
448	4095	Caetana	Andrade	F	Mocambique	Nampula	Inhambane	Mocambicana	C	2001-06-19	Laboral	UP-Massinga	Colegio Arco-iris	46	68	Superior	020890912264Q
449	4096	Érica	Sá	F	Mocambique	Manica	Inhambane	Mocambicana	D	1998-09-18	Laboral	UP-Xai-Xai	Colegio Arco-iris	38	44	Superior	490178376896S
450	4097	Dinis	Ramos	M	Mocambique	Gaza	Maputo	Mocambicana	D	2001-06-28	Laboral	UP-Gurue	Escola Secundária da Maxixe	45	65	Superior	152152501012W
451	4098	Leandro	Oliveira	F	Mocambique	Cidade de Maputo	Cabo Delgado	Mocambicana	D	2000-06-05	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	58	51	Superior	172713147718M
452	4099	Bárbara	Vicente	M	Mocambique	Nampula	Niassa	Mocambicana	S	2002-07-08	Pos-Laboral	UP-Massinga	Colegio Arco-iris	47	38	Superior	291933087834W
453	4100	Iara	Melo	M	Mocambique	Gaza	Maputo	Mocambicana	V	2001-05-27	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	42	53	Superior	364692537529M
454	4101	Rita	Henriques	M	Mocambique	Inhambane	Niassa	Mocambicana	D	1996-05-30	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	37	66	Superior	175981080407O
455	4102	Ricardo	Guerreiro	M	Mocambique	Zambézia	Maputo	Mocambicana	V	2006-05-13	Laboral	UP-Quelimane	Escola Secundária da Maxixe	39	59	Superior	034983133676B
456	4103	Mariana	Guerreiro	F	Mocambique	Inhambane	Cidade de Maputo	Mocambicana	S	2002-02-25	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	61	62	Superior	851389858583L
457	4104	Juliana	Alves	F	Mocambique	Cabo Delgado	Gaza	Mocambicana	D	2000-04-11	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	53	37	Superior	227237512845E
458	4105	Cláudio	Figueiredo	F	Mocambique	Niassa	Maputo	Mocambicana	S	1995-04-14	Laboral	UP-Massinga	Colegio Arco-iris	64	67	Superior	406966976834W
459	4106	Simão	Neves	M	Mocambique	Inhambane	Nampula	Mocambicana	S	2000-02-07	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	38	35	Superior	744550885805N
460	4107	Marcos	Vicente	M	Mocambique	Cidade de Maputo	Cabo Delgado	Mocambicana	V	1996-12-23	Laboral	UP-Gurue	Escola Secundária da Maxixe	58	61	Superior	934604104576F
461	4108	Constança	Lopes	M	Mocambique	Manica	Cabo Delgado	Mocambicana	C	1997-06-23	Laboral	UP-Quelimane	Escola Secundária da Maxixe	58	61	Superior	128716376290J
462	4109	Micael	Amorim	F	Mocambique	Nampula	Sofala	Mocambicana	S	2006-11-10	Laboral	UP-Quelimane	Colegio Arco-iris	68	58	Superior	326160180825Z
463	4110	Débora	Lopes	M	Mocambique	Maputo	Maputo	Mocambicana	V	2003-02-11	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	38	40	Superior	503503842848W
464	4111	Margarida	Campos	M	Mocambique	Tete	Gaza	Mocambicana	C	2006-02-07	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	37	62	Superior	860372963807J
465	4112	Fernando	Cardoso	M	Mocambique	Tete	Cabo Delgado	Mocambicana	V	1999-12-31	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	58	39	Superior	732731244515F
466	4113	Mariana	Matos	M	Mocambique	Zambézia	Tete	Mocambicana	C	1996-05-29	Laboral	UP-Massinga	Colegio Arco-iris	42	48	Superior	434320299307A
467	4114	Gustavo	Fernandes	F	Mocambique	Nampula	Nampula	Mocambicana	V	2006-02-05	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	57	65	Superior	712919696733Y
468	4115	Iara	Neves	M	Mocambique	Maputo	Zambézia	Mocambicana	C	1995-07-19	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	38	40	Superior	424579093764M
469	4116	Rodrigo	Correia	M	Mocambique	Maputo	Niassa	Mocambicana	D	2002-05-25	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	39	65	Superior	282638325324I
470	4117	Diana	Oliveira	F	Mocambique	Zambézia	Maputo	Mocambicana	V	2001-05-16	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	36	43	Superior	036686240247G
471	4118	Tomé	Teixeira	F	Mocambique	Cabo Delgado	Manica	Mocambicana	S	1995-03-30	Laboral	UP-Gurue	Colegio Arco-iris	52	51	Superior	999625873972W
472	4119	Filipe	Costa	M	Mocambique	Maputo	Sofala	Mocambicana	S	2000-06-22	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	43	65	Superior	860222774095K
473	4120	Maria	Domingues	F	Mocambique	Manica	Inhambane	Mocambicana	S	2002-06-11	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	66	51	Superior	193793569323F
474	4121	Benjamim	Marques	F	Mocambique	Manica	Maputo	Mocambicana	V	1997-03-18	Laboral	UP-Quelimane	Escola Secundária da Maxixe	39	52	Superior	981235179243P
475	4122	António	Nunes	M	Mocambique	Tete	Sofala	Mocambicana	V	2001-06-17	Laboral	UP-Lichinga	Escola Secundária da Maxixe	47	59	Superior	247298486144W
476	4123	Sebastião	Tavares	M	Mocambique	Cidade de Maputo	Sofala	Mocambicana	V	2001-09-21	Laboral	UP-Massinga	Escola Secundária da Maxixe	64	58	Superior	605984417241T
477	4124	Isabela	Vieira	M	Mocambique	Niassa	Gaza	Mocambicana	S	1997-07-13	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	44	41	Superior	407945173400X
478	4125	Nelson	Pinto	M	Mocambique	Inhambane	Sofala	Mocambicana	S	2004-10-02	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	68	36	Superior	255227824458P
479	4126	Vitória	Esteves	F	Mocambique	Sofala	Maputo	Mocambicana	V	2004-04-04	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	64	40	Superior	951649376765G
480	4127	Luca	Gaspar	F	Mocambique	Manica	Cabo Delgado	Mocambicana	D	1995-10-15	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	35	54	Superior	118665508920M
481	4128	Júlia	Barros	F	Mocambique	Inhambane	Zambézia	Mocambicana	D	1995-08-12	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	53	46	Superior	549097096837N
482	4129	Marta	Vicente	F	Mocambique	Niassa	Gaza	Mocambicana	C	2002-09-13	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	36	54	Superior	331997000879H
483	4130	Madalena	Pacheco	F	Mocambique	Cabo Delgado	Gaza	Mocambicana	V	1998-09-18	Laboral	UP-Lichinga	Colegio Arco-iris	56	39	Superior	296296492062Z
484	4131	Francisca	Mota	M	Mocambique	Zambézia	Maputo	Mocambicana	V	2002-10-15	Laboral	UP-Massinga	Escola Secundária da Maxixe	43	39	Superior	535599888582S
485	4132	Hugo	Azevedo	M	Mocambique	Tete	Zambézia	Mocambicana	D	2002-08-20	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	45	62	Superior	911385507841Y
486	4133	Diego	Soares	F	Mocambique	Cidade de Maputo	Tete	Mocambicana	D	2005-11-29	Laboral	UP-Lichinga	Colegio Arco-iris	43	63	Superior	852498275270D
487	4134	Fábio	Oliveira	M	Mocambique	Maputo	Sofala	Mocambicana	D	1997-08-04	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	40	68	Superior	952446087549W
488	4135	Filipa	Leite	M	Mocambique	Niassa	Inhambane	Mocambicana	D	2006-04-13	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	58	47	Superior	719218227457L
489	4136	Jéssica	Simões	F	Mocambique	Cidade de Maputo	Sofala	Mocambicana	C	1997-09-20	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	64	66	Superior	389400964011G
490	4137	Luna	Pereira	M	Mocambique	Tete	Gaza	Mocambicana	D	2004-09-30	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	41	51	Superior	503867301901R
491	4138	Martim	Sousa	M	Mocambique	Gaza	Tete	Mocambicana	S	1997-07-17	Laboral	UP-Massinga	Escola Secundária da Maxixe	44	45	Superior	432447553066P
492	4139	Mauro	Castro	F	Mocambique	Manica	Maputo	Mocambicana	V	1995-09-17	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	67	61	Superior	941648020407D
493	4140	Matilde	Mota	F	Mocambique	Gaza	Cidade de Maputo	Mocambicana	V	2003-06-22	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	62	59	Superior	111026960969B
494	4141	Juliana	Oliveira	F	Mocambique	Niassa	Nampula	Mocambicana	C	1998-08-21	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	46	54	Superior	560758515179M
495	4142	Carlos	Andrade	M	Mocambique	Maputo	Cabo Delgado	Mocambicana	D	2002-09-26	Laboral	UP-Lichinga	Escola Secundária da Maxixe	49	45	Superior	705043937186H
496	4143	Anita	Pereira	M	Mocambique	Inhambane	Sofala	Mocambicana	C	2004-10-12	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	53	47	Superior	744142566018Q
497	4144	Kevin	Carneiro	F	Mocambique	Inhambane	Tete	Mocambicana	S	1997-11-19	Pos-Laboral	UP-Gurue	Colegio Arco-iris	36	56	Superior	694188762023H
498	4145	Bryan	Barbosa	F	Mocambique	Sofala	Maputo	Mocambicana	V	2005-06-08	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	58	63	Superior	587186308377T
499	4146	Nelson	Fernandes	F	Mocambique	Gaza	Tete	Mocambicana	S	2000-09-01	Laboral	UP-Gurue	Colegio Arco-iris	39	63	Superior	064533823870H
500	4147	Luciana	Domingues	M	Mocambique	Gaza	Sofala	Mocambicana	C	2005-01-23	Laboral	UP-Massinga	Colegio Arco-iris	46	43	Superior	184650561382Y
501	4148	Artur	Neto	F	Mocambique	Tete	Maputo	Mocambicana	S	1999-04-05	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	68	51	Superior	176378604795S
502	4149	Salvador	Amorim	F	Mocambique	Zambézia	Nampula	Mocambicana	C	1998-01-14	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	54	39	Superior	010178509563X
503	4150	Érica	Castro	F	Mocambique	Manica	Inhambane	Mocambicana	C	1997-09-25	Laboral	UP-Quelimane	Colegio Arco-iris	61	38	Superior	726834031003J
504	4151	Carlota	Coelho	F	Mocambique	Cabo Delgado	Gaza	Mocambicana	C	2000-07-24	Laboral	UP-Lichinga	Colegio Arco-iris	56	57	Superior	572038153299P
505	4152	Rafaela	Marques	F	Mocambique	Tete	Sofala	Mocambicana	C	2006-05-15	Laboral	UP-Gurue	Colegio Arco-iris	61	64	Superior	481910188366R
506	4153	Joaquim	Pinho	F	Mocambique	Niassa	Cabo Delgado	Mocambicana	V	2002-08-10	Laboral	UP-Massinga	Escola Secundária da Maxixe	62	59	Superior	252939618535F
507	4154	Rafael	Fonseca	M	Mocambique	Cabo Delgado	Sofala	Mocambicana	S	1998-03-30	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	49	46	Superior	592519369390N
508	4155	Diego	Loureiro	F	Mocambique	Zambézia	Cabo Delgado	Mocambicana	S	1997-07-29	Laboral	UP-Quelimane	Escola Secundária da Maxixe	65	41	Superior	313792118470F
509	4156	Mariana	Neto	F	Mocambique	Gaza	Sofala	Mocambicana	D	2000-02-11	Laboral	UP-Xai-Xai	Colegio Arco-iris	52	43	Superior	926502411625T
510	4157	Lúcia	Azevedo	M	Mocambique	Maputo	Inhambane	Mocambicana	V	2002-02-08	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	53	61	Superior	889744506819F
511	4158	Melissa	Pires	M	Mocambique	Cidade de Maputo	Nampula	Mocambicana	V	1999-04-20	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	40	66	Superior	632687142016U
512	4159	Érica	Henriques	F	Mocambique	Tete	Maputo	Mocambicana	S	2003-02-07	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	62	35	Superior	014594586941U
513	4160	Madalena	Esteves	M	Mocambique	Niassa	Maputo	Mocambicana	V	2002-04-25	Laboral	UP-Lichinga	Escola Secundária da Maxixe	67	50	Superior	659854372251B
514	4161	Enzo	Barbosa	M	Mocambique	Tete	Manica	Mocambicana	D	1999-07-06	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	52	44	Superior	777028576451Y
515	4162	Rita	Figueiredo	M	Mocambique	Gaza	Manica	Mocambicana	S	2006-08-19	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	68	49	Superior	247429472857L
516	4163	Rita	Sousa	F	Mocambique	Cabo Delgado	Maputo	Mocambicana	S	1999-09-20	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	37	61	Superior	390838863608J
517	4164	Juliana	Pires	M	Mocambique	Cabo Delgado	Inhambane	Mocambicana	S	2004-11-22	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	50	44	Superior	878278180767N
518	4165	Kelly	Morais	F	Mocambique	Gaza	Gaza	Mocambicana	C	2006-11-05	Laboral	UP-Massinga	Escola Secundária da Maxixe	57	61	Superior	675683949098B
519	4166	Nádia	Pires	F	Mocambique	Sofala	Niassa	Mocambicana	D	2001-08-20	Laboral	UP-Gurue	Escola Secundária da Maxixe	38	64	Superior	892032003505V
520	4167	Enzo	Matos	M	Mocambique	Niassa	Cabo Delgado	Mocambicana	S	1997-02-11	Pos-Laboral	UP-Massinga	Colegio Arco-iris	36	62	Superior	216239141777T
521	4168	Erika	Esteves	F	Mocambique	Tete	Zambézia	Mocambicana	C	1996-01-01	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	38	45	Superior	635683098446G
522	4169	Joaquim	Brito	M	Mocambique	Nampula	Cabo Delgado	Mocambicana	V	2001-03-24	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	48	35	Superior	122012813220M
523	4170	Tatiana	Gaspar	M	Mocambique	Inhambane	Nampula	Mocambicana	C	2001-09-22	Laboral	UP-Gurue	Colegio Arco-iris	49	43	Superior	242327530119L
524	4171	Bernardo	Azevedo	F	Mocambique	Tete	Nampula	Mocambicana	D	2005-12-13	Pos-Laboral	UP-Massinga	Colegio Arco-iris	52	58	Superior	891732992790X
525	4172	Frederico	Soares	M	Mocambique	Inhambane	Zambézia	Mocambicana	V	1999-03-14	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	63	57	Superior	067397394171P
526	4173	Filipe	Andrade	F	Mocambique	Tete	Cabo Delgado	Mocambicana	S	1995-10-28	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	45	41	Superior	300936919102B
527	4174	Eduarda	Antunes	M	Mocambique	Tete	Inhambane	Mocambicana	V	1997-06-25	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	65	66	Superior	513579165906M
528	4175	Erica	Matos	M	Mocambique	Zambézia	Gaza	Mocambicana	V	1999-02-11	Laboral	UP-Quelimane	Colegio Arco-iris	47	43	Superior	063022827482E
529	4176	Sebastião	Antunes	F	Mocambique	Tete	Nampula	Mocambicana	V	2001-01-20	Laboral	UP-Gurue	Colegio Arco-iris	59	44	Superior	448340401106U
530	4177	Alice	Vicente	F	Mocambique	Tete	Cidade de Maputo	Mocambicana	V	2001-01-08	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	68	45	Superior	209643046873N
531	4178	Wilson	Maia	M	Mocambique	Zambézia	Nampula	Mocambicana	C	2003-05-14	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	44	42	Superior	187303638749K
532	4179	Duarte	Pacheco	M	Mocambique	Nampula	Inhambane	Mocambicana	S	1998-03-01	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	61	68	Superior	750069641082B
533	4180	Inês	Neves	F	Mocambique	Cidade de Maputo	Nampula	Mocambicana	C	1999-05-06	Pos-Laboral	UP-Gurue	Colegio Arco-iris	62	51	Superior	893679252085B
534	4181	Renato	Valente	F	Mocambique	Niassa	Inhambane	Mocambicana	C	2000-09-08	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	45	44	Superior	222010379564K
535	4182	Martim	Monteiro	M	Mocambique	Cidade de Maputo	Zambézia	Mocambicana	D	2001-07-11	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	54	38	Superior	734453827806J
536	4183	Camila	Lourenço	F	Mocambique	Cabo Delgado	Niassa	Mocambicana	S	2002-05-09	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	67	63	Superior	440435652376X
537	4184	Paulo	Moreira	F	Mocambique	Niassa	Inhambane	Mocambicana	S	2002-01-11	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	60	62	Superior	746857766825K
538	4185	Bruno	Martins	M	Mocambique	Cidade de Maputo	Nampula	Mocambicana	C	1995-08-04	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	52	47	Superior	444807949948V
539	4186	Benjamim	Barros	M	Mocambique	Gaza	Tete	Mocambicana	V	2004-12-10	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	55	46	Superior	586626031312Q
540	4187	Gustavo	Sousa	M	Mocambique	Zambézia	Cidade de Maputo	Mocambicana	V	1998-04-12	Laboral	UP-Lichinga	Escola Secundária da Maxixe	35	39	Superior	392924327600Z
541	4188	Joel	Oliveira	F	Mocambique	Gaza	Nampula	Mocambicana	V	1996-08-20	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	67	68	Superior	173071980236T
542	4189	Iara	Barbosa	F	Mocambique	Inhambane	Maputo	Mocambicana	V	1996-01-21	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	47	41	Superior	587808097836R
543	4190	Vicente	Jesus	M	Mocambique	Niassa	Gaza	Mocambicana	D	2006-05-26	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	59	35	Superior	257626322312F
544	4191	Leonardo	Cunha	F	Mocambique	Cabo Delgado	Manica	Mocambicana	V	1998-10-01	Laboral	UP-Gurue	Colegio Arco-iris	58	61	Superior	319517871367S
545	4192	Ivo	Pinheiro	F	Mocambique	Gaza	Zambézia	Mocambicana	S	1998-04-23	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	38	46	Superior	942648799232G
546	4193	Jorge	Alves	F	Mocambique	Niassa	Nampula	Mocambicana	S	2001-09-15	Laboral	UP-Gurue	Escola Secundária da Maxixe	44	68	Superior	278136843191I
547	4194	Emanuel	Freitas	M	Mocambique	Maputo	Zambézia	Mocambicana	D	2000-03-12	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	35	46	Superior	610685137351O
548	4195	Renato	Pinho	F	Mocambique	Maputo	Maputo	Mocambicana	V	1995-06-07	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	59	38	Superior	455277523748A
549	4196	Rodrigo	Lourenço	F	Mocambique	Sofala	Tete	Mocambicana	V	1995-04-15	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	55	60	Superior	658204868757C
550	4197	Matias	Freitas	F	Mocambique	Manica	Niassa	Mocambicana	C	2005-03-31	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	38	36	Superior	152969418561V
551	4198	Patrícia	Fonseca	F	Mocambique	Inhambane	Cabo Delgado	Mocambicana	C	1995-04-26	Laboral	UP-Massinga	Colegio Arco-iris	36	56	Superior	270602419230B
552	4199	Raquel	Nogueira	M	Mocambique	Inhambane	Zambézia	Mocambicana	S	2002-05-03	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	61	41	Superior	387711183255F
553	4200	Isabela	Carneiro	F	Mocambique	Inhambane	Nampula	Mocambicana	S	2005-11-11	Pos-Laboral	UP-Massinga	Colegio Arco-iris	45	66	Superior	303126798831R
554	4201	Igor	Moreira	M	Mocambique	Zambézia	Cabo Delgado	Mocambicana	C	2006-10-03	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	53	56	Superior	584135927897D
555	4202	Mafalda	Martins	M	Mocambique	Maputo	Gaza	Mocambicana	S	2004-05-18	Laboral	UP-Massinga	Escola Secundária da Maxixe	61	36	Superior	253343220934Z
556	4203	Bryan	Nunes	F	Mocambique	Nampula	Niassa	Mocambicana	D	2000-07-18	Laboral	UP-Gurue	Colegio Arco-iris	67	68	Superior	995303495051H
557	4204	Yasmin	Amaral	F	Mocambique	Nampula	Sofala	Mocambicana	D	2004-09-06	Laboral	UP-Xai-Xai	Colegio Arco-iris	37	54	Superior	715035424872B
558	4205	Denis	Baptista	F	Mocambique	Zambézia	Inhambane	Mocambicana	V	1997-11-06	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	61	59	Superior	324823802042S
559	4206	Bárbara	Lourenço	F	Mocambique	Manica	Maputo	Mocambicana	V	2001-03-27	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	68	57	Superior	341812094919L
560	4207	Cristiano	Esteves	F	Mocambique	Cidade de Maputo	Manica	Mocambicana	D	1996-12-29	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	65	62	Superior	012440378133C
561	4208	Larissa	Loureiro	F	Mocambique	Cabo Delgado	Nampula	Mocambicana	S	2006-03-29	Laboral	UP-Massinga	Colegio Arco-iris	55	36	Superior	524386808847F
562	4209	Salvador	Batista	F	Mocambique	Zambézia	Tete	Mocambicana	C	1998-07-28	Laboral	UP-Quelimane	Escola Secundária da Maxixe	65	37	Superior	149310015120H
563	4210	Gonçalo	Ramos	F	Mocambique	Gaza	Niassa	Mocambicana	V	2000-09-30	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	39	64	Superior	588478962172U
564	4211	Benjamim	Miranda	F	Mocambique	Inhambane	Tete	Mocambicana	V	2004-07-09	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	61	37	Superior	289772985049M
565	4212	Duarte	Ferreira	F	Mocambique	Cidade de Maputo	Cidade de Maputo	Mocambicana	C	1999-11-24	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	56	52	Superior	673677664099R
566	4213	Eduardo	Carvalho	M	Mocambique	Zambézia	Gaza	Mocambicana	C	1997-09-20	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	68	55	Superior	072236104224S
567	4214	Paulo	Gonçalves	M	Mocambique	Gaza	Cidade de Maputo	Mocambicana	V	2005-01-04	Laboral	UP-Lichinga	Escola Secundária da Maxixe	46	43	Superior	765132587070O
568	4215	Carlos	Guerreiro	F	Mocambique	Maputo	Cidade de Maputo	Mocambicana	V	1998-11-23	Laboral	UP-Xai-Xai	Colegio Arco-iris	54	38	Superior	459582316572I
569	4216	Ivan	Araújo	M	Mocambique	Zambézia	Niassa	Mocambicana	C	2005-09-03	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	39	59	Superior	903595163209R
570	4217	Fernando	Vaz	F	Mocambique	Zambézia	Sofala	Mocambicana	S	2002-09-09	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	66	39	Superior	490356496714S
571	4218	Letícia	Batista	M	Mocambique	Tete	Nampula	Mocambicana	D	2005-07-06	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	46	56	Superior	814049413260T
572	4219	Martim	Jesus	F	Mocambique	Cidade de Maputo	Maputo	Mocambicana	V	2005-08-25	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	44	64	Superior	481304698916R
573	4220	Afonso	Morais	F	Mocambique	Manica	Manica	Mocambicana	V	2002-03-16	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	47	61	Superior	484154938943R
574	4221	Lourenço	Correia	F	Mocambique	Cidade de Maputo	Tete	Mocambicana	D	1996-01-18	Laboral	UP-Massinga	Escola Secundária da Maxixe	50	37	Superior	346921384516X
575	4222	William	Silva	F	Mocambique	Inhambane	Cidade de Maputo	Mocambicana	V	2002-03-19	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	46	63	Superior	746454613899Y
576	4223	Luana	Pires	F	Mocambique	Gaza	Tete	Mocambicana	V	1998-07-15	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	39	55	Superior	985096811646R
577	4224	Frederico	Martins	F	Mocambique	Manica	Sofala	Mocambicana	S	1995-10-10	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	58	45	Superior	441123156173A
578	4225	Flor	Pinto	F	Mocambique	Niassa	Cidade de Maputo	Mocambicana	S	1997-06-15	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	40	60	Superior	883213958329R
579	4226	Mafalda	Gonçalves	F	Mocambique	Manica	Tete	Mocambicana	D	1995-03-08	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	55	56	Superior	098402946489R
580	4227	Filipa	Moreira	M	Mocambique	Zambézia	Cidade de Maputo	Mocambicana	S	1997-07-15	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	64	46	Superior	150020983598H
581	4228	Nádia	Ramos	F	Mocambique	Sofala	Cidade de Maputo	Mocambicana	C	2005-09-27	Laboral	UP-Lichinga	Colegio Arco-iris	59	54	Superior	427430754180W
582	4229	Álvaro	Gaspar	F	Mocambique	Gaza	Cabo Delgado	Mocambicana	C	2005-04-16	Laboral	UP-Xai-Xai	Colegio Arco-iris	47	54	Superior	755793918632L
583	4230	Noah	Mota	F	Mocambique	Tete	Gaza	Mocambicana	S	2002-01-14	Laboral	UP-Quelimane	Escola Secundária da Maxixe	54	37	Superior	327723675083F
584	4231	Frederico	Campos	F	Mocambique	Cidade de Maputo	Manica	Mocambicana	S	1998-02-03	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	48	52	Superior	256988080795W
585	4232	Noa	Andrade	F	Mocambique	Gaza	Nampula	Mocambicana	D	2003-06-15	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	64	48	Superior	480541004287I
586	4233	Filipa	Torres	F	Mocambique	Nampula	Zambézia	Mocambicana	S	2003-12-07	Laboral	UP-Quelimane	Escola Secundária da Maxixe	45	55	Superior	707903912069F
587	4234	Tiago	Simões	F	Mocambique	Manica	Maputo	Mocambicana	D	1995-08-12	Pos-Laboral	UP-Gurue	Colegio Arco-iris	41	64	Superior	146419903713Z
588	4235	Renata	Garcia	F	Mocambique	Manica	Inhambane	Mocambicana	V	2002-06-01	Laboral	UP-Massinga	Escola Secundária da Maxixe	38	61	Superior	311525075856A
589	4236	David	Pacheco	M	Mocambique	Cidade de Maputo	Niassa	Mocambicana	D	1997-10-06	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	54	50	Superior	576856816388L
590	4237	Noa	Morais	M	Mocambique	Manica	Inhambane	Mocambicana	V	2001-08-31	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	35	47	Superior	563246518794K
591	4238	Leandro	Lima	F	Mocambique	Gaza	Manica	Mocambicana	C	2002-07-26	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	45	61	Superior	888531987299V
592	4239	Luciana	Macedo	M	Mocambique	Cidade de Maputo	Sofala	Mocambicana	D	1997-01-27	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	62	52	Superior	758742250978X
593	4240	Camila	Amaral	M	Mocambique	Nampula	Inhambane	Mocambicana	D	2006-01-14	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	49	55	Superior	572089599697R
594	4241	Leonardo	Barros	M	Mocambique	Maputo	Cabo Delgado	Mocambicana	C	1996-07-02	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	50	49	Superior	991710589624W
595	4242	Erica	Baptista	M	Mocambique	Niassa	Tete	Mocambicana	S	2001-10-06	Laboral	UP-Xai-Xai	Colegio Arco-iris	54	51	Superior	313927886869D
596	4243	William	Sá	M	Mocambique	Tete	Sofala	Mocambicana	V	2004-05-25	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	40	44	Superior	518581674621E
597	4244	Inês	Borges	M	Mocambique	Tete	Manica	Mocambicana	C	2004-04-17	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	52	48	Superior	120842624302F
598	4245	Carlos	Esteves	M	Mocambique	Maputo	Niassa	Mocambicana	V	2005-10-29	Pos-Laboral	UP-Gurue	Colegio Arco-iris	68	39	Superior	026080706222M
599	4246	Iara	Cruz	F	Mocambique	Zambézia	Zambézia	Mocambicana	S	2003-03-21	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	36	61	Superior	929932285694H
600	4247	Artur	Branco	M	Mocambique	Cabo Delgado	Manica	Mocambicana	C	2002-02-03	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	44	65	Superior	960471746295W
601	4248	Lúcia	Neves	M	Mocambique	Zambézia	Tete	Mocambicana	C	2001-10-11	Laboral	UP-Quelimane	Escola Secundária da Maxixe	66	60	Superior	981898102744C
602	4249	Eduarda	Ribeiro	F	Mocambique	Niassa	Gaza	Mocambicana	C	2005-01-08	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	41	53	Superior	491689594756Q
603	4250	Ricardo	Cruz	F	Mocambique	Gaza	Maputo	Mocambicana	S	1995-02-10	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	44	47	Superior	083212380199M
604	4251	Júlia	Mendes	M	Mocambique	Cabo Delgado	Sofala	Mocambicana	C	2002-12-05	Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	49	59	Superior	418617204983D
605	4252	Cristiano	Borges	M	Mocambique	Cidade de Maputo	Gaza	Mocambicana	V	2000-02-02	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	35	50	Superior	286744303079K
606	4253	Edgar	Brito	M	Mocambique	Maputo	Niassa	Mocambicana	C	2002-07-25	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	53	58	Superior	446185156961F
607	4254	Eduardo	Campos	M	Mocambique	Cabo Delgado	Gaza	Mocambicana	V	1999-05-15	Laboral	UP-Xai-Xai	Colegio Arco-iris	58	61	Superior	629283587557R
608	4255	Fabiana	Andrade	M	Mocambique	Tete	Manica	Mocambicana	C	1997-09-27	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	37	52	Superior	893088727599M
609	4256	Marta	Miranda	F	Mocambique	Maputo	Zambézia	Mocambicana	D	2006-08-16	Laboral	UP-Massinga	Escola Secundária da Maxixe	65	43	Superior	668306954154U
610	4257	Cláudio	Barbosa	M	Mocambique	Gaza	Niassa	Mocambicana	C	1995-10-19	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	48	38	Superior	402204189308O
611	4258	Samuel	Paiva	M	Mocambique	Zambézia	Cabo Delgado	Mocambicana	S	1996-07-07	Laboral	UP-Massinga	Colegio Arco-iris	54	68	Superior	127537353447O
612	4259	Lisandro	Cunha	F	Mocambique	Maputo	Zambézia	Mocambicana	S	1998-05-28	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	52	39	Superior	923751872831P
613	4260	Mia	Pires	M	Mocambique	Maputo	Nampula	Mocambicana	D	1997-12-03	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	37	47	Superior	795548852611M
614	4261	Jorge	Magalhães	M	Mocambique	Inhambane	Inhambane	Mocambicana	D	1999-10-16	Laboral	UP-Lichinga	Colegio Arco-iris	35	58	Superior	510381139389J
615	4262	Ema	Matias	F	Mocambique	Cabo Delgado	Niassa	Mocambicana	D	2003-12-30	Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	49	61	Superior	490982434346W
616	4263	Rafaela	Baptista	M	Mocambique	Maputo	Maputo	Mocambicana	S	2002-01-20	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	66	42	Superior	838654261423J
617	4264	Benedita	Lima	M	Mocambique	Nampula	Nampula	Mocambicana	D	2001-08-27	Pos-Laboral	UP-Gurue	Colegio Arco-iris	35	42	Superior	371320235324N
618	4265	Renata	Borges	F	Mocambique	Cidade de Maputo	Cidade de Maputo	Mocambicana	S	1999-09-15	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	35	46	Superior	089424637869W
619	4266	Martim	Amorim	M	Mocambique	Inhambane	Maputo	Mocambicana	D	2002-05-03	Laboral	UP-Xai-Xai	Colegio Arco-iris	58	63	Superior	860862535006A
620	4267	Helena	Andrade	F	Mocambique	Cabo Delgado	Tete	Mocambicana	S	1995-07-12	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	64	42	Superior	128745476671L
621	4268	Leonor	Rocha	F	Mocambique	Gaza	Zambézia	Mocambicana	C	1998-01-26	Laboral	UP-Quelimane	Colegio Arco-iris	66	44	Superior	600817961602J
622	4269	Jéssica	Campos	F	Mocambique	Zambézia	Nampula	Mocambicana	S	1999-07-27	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	51	43	Superior	854483282659X
623	4270	David	Tavares	F	Mocambique	Maputo	Niassa	Mocambicana	S	2005-09-10	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	64	35	Superior	236147488246I
624	4271	Helena	Azevedo	M	Mocambique	Maputo	Zambézia	Mocambicana	D	1998-11-28	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	67	64	Superior	455346743369E
625	4272	Melissa	Gonçalves	M	Mocambique	Inhambane	Sofala	Mocambicana	V	2005-01-31	Pos-Laboral	UP-Massinga	Colegio Arco-iris	66	37	Superior	341014016583W
626	4273	Catarina	Monteiro	F	Mocambique	Manica	Niassa	Mocambicana	S	2003-02-02	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	48	67	Superior	128701009038M
627	4274	Luís	Correia	F	Mocambique	Tete	Inhambane	Mocambicana	S	2005-06-11	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	38	64	Superior	202771985186J
628	4275	Jaime	Matias	F	Mocambique	Inhambane	Gaza	Mocambicana	V	2000-10-29	Laboral	UP-Gurue	Colegio Arco-iris	65	35	Superior	177231664591H
629	4276	Tomás	Domingues	M	Mocambique	Maputo	Zambézia	Mocambicana	S	1995-06-30	Laboral	UP-Lichinga	Colegio Arco-iris	49	59	Superior	994038469179L
630	4277	Sérgio	Matias	F	Mocambique	Gaza	Maputo	Mocambicana	V	2006-09-28	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	53	62	Superior	311039903706M
631	4278	Igor	Castro	F	Mocambique	Gaza	Inhambane	Mocambicana	D	1996-08-05	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	56	49	Superior	435573504416Z
632	4279	Wilson	Branco	F	Mocambique	Tete	Sofala	Mocambicana	V	2005-02-04	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	45	54	Superior	861373153053X
633	4280	Nelson	Sousa	F	Mocambique	Nampula	Cidade de Maputo	Mocambicana	S	1995-01-20	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	38	55	Superior	346439394695D
634	4281	Débora	Antunes	F	Mocambique	Maputo	Maputo	Mocambicana	D	1996-08-23	Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	61	38	Superior	316932340867T
635	4282	Tiago	Neto	F	Mocambique	Cidade de Maputo	Tete	Mocambicana	C	1997-09-27	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	51	61	Superior	696848631426N
636	4283	Lorena	Alves	M	Mocambique	Inhambane	Sofala	Mocambicana	V	2000-11-09	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	36	56	Superior	445793739774A
637	4284	Márcio	Neto	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	C	1996-07-03	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	36	52	Superior	961483915436W
638	4285	Brian	Faria	F	Mocambique	Maputo	Cidade de Maputo	Mocambicana	S	1997-12-01	Laboral	UP-Gurue	Escola Secundária da Maxixe	47	39	Superior	573592478341W
639	4286	Gabriel	Magalhães	F	Mocambique	Cabo Delgado	Zambézia	Mocambicana	C	1998-02-04	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	41	67	Superior	428556708307H
640	4287	Igor	Amaral	F	Mocambique	Manica	Manica	Mocambicana	C	2002-09-23	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	63	44	Superior	281990855860Y
641	4288	Miriam	Correia	F	Mocambique	Inhambane	Sofala	Mocambicana	V	2000-12-04	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	43	38	Superior	077726256410T
642	4289	Erika	Loureiro	M	Mocambique	Manica	Zambézia	Mocambicana	C	1996-12-12	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	54	57	Superior	828069168815H
643	4290	Eva	Henriques	M	Mocambique	Cabo Delgado	Inhambane	Mocambicana	S	1996-12-29	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	53	49	Superior	528895681092Y
644	4291	Daniel	Fonseca	F	Mocambique	Nampula	Cidade de Maputo	Mocambicana	D	2001-08-22	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	46	62	Superior	270903821990U
645	4292	Isaac	Neto	M	Mocambique	Manica	Cidade de Maputo	Mocambicana	S	1997-05-11	Laboral	UP-Quelimane	Colegio Arco-iris	42	40	Superior	704855471024P
646	4293	Leonardo	Nascimento	F	Mocambique	Manica	Manica	Mocambicana	D	2001-12-27	Laboral	UP-Quelimane	Escola Secundária da Maxixe	66	40	Superior	702337975780X
647	4294	Fabiana	Antunes	M	Mocambique	Niassa	Niassa	Mocambicana	D	2002-07-20	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	50	47	Superior	959118771247F
648	4295	Erika	Abreu	F	Mocambique	Cabo Delgado	Tete	Mocambicana	C	2001-08-30	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	64	54	Superior	081120525002M
649	4296	Filipe	Santos	M	Mocambique	Niassa	Maputo	Mocambicana	C	1998-05-13	Laboral	UP-Xai-Xai	Colegio Arco-iris	41	60	Superior	115624590558K
650	4297	Marcos	Ribeiro	M	Mocambique	Manica	Zambézia	Mocambicana	S	2000-12-17	Pos-Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	54	40	Superior	703136465117G
651	4298	Iara	Cardoso	M	Mocambique	Tete	Gaza	Mocambicana	S	1998-04-18	Laboral	UP-Massinga	Colegio Arco-iris	58	38	Superior	333283748036M
652	4299	Lara	Almeida	M	Mocambique	Nampula	Manica	Mocambicana	S	1999-01-24	Laboral	UP-Xai-Xai	Colegio Arco-iris	57	60	Superior	646374753360Y
653	4300	Emília	Torres	F	Mocambique	Zambézia	Maputo	Mocambicana	V	2003-01-12	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	42	55	Superior	780798964702X
654	4301	Luna	Cardoso	F	Mocambique	Sofala	Nampula	Mocambicana	D	1998-04-04	Pos-Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	60	55	Superior	244425647944J
655	4302	Renata	Correia	M	Mocambique	Manica	Nampula	Mocambicana	V	1996-07-09	Pos-Laboral	UP-Xai-Xai	Instituto Pré-Universitário de Tete	60	36	Superior	921120185530B
656	4303	Tomé	Barros	M	Mocambique	Inhambane	Maputo	Mocambicana	C	2001-06-19	Laboral	UP-Gurue	Escola Secundária da Maxixe	48	67	Superior	944021734059E
657	4304	Gabriela	Tavares	F	Mocambique	Zambézia	Zambézia	Mocambicana	C	2006-11-04	Laboral	UP-Quelimane	Colegio Arco-iris	38	65	Superior	268441120652A
658	4305	Cristiano	Gomes	M	Mocambique	Inhambane	Maputo	Mocambicana	C	2001-06-23	Pos-Laboral	UP-Lichinga	Escola Secundária da Maxixe	65	67	Superior	466817846463Z
659	4306	Lúcia	Barros	M	Mocambique	Cidade de Maputo	Manica	Mocambicana	D	2003-07-12	Laboral	UP-Lichinga	Colegio Arco-iris	50	64	Superior	877910694648D
660	4307	Francisco	Vieira	M	Mocambique	Gaza	Zambézia	Mocambicana	C	1997-02-28	Laboral	UP-Lichinga	Escola Secundária da Maxixe	58	64	Superior	877185210627U
661	4308	Alícia	Vaz	F	Mocambique	Niassa	Inhambane	Mocambicana	V	2000-08-29	Laboral	UP-Gurue	Colegio Arco-iris	47	45	Superior	907346529876P
662	4309	Noah	Abreu	M	Mocambique	Cabo Delgado	Manica	Mocambicana	S	1996-09-28	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	60	56	Superior	762184542868B
663	4310	Sara	Torres	F	Mocambique	Gaza	Sofala	Mocambicana	S	2001-11-02	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	57	35	Superior	248519143255W
664	4311	Mariana	Andrade	F	Mocambique	Gaza	Cidade de Maputo	Mocambicana	C	1996-10-17	Laboral	UP-Massinga	Colegio Arco-iris	68	39	Superior	444574555469E
665	4312	Mélanie	Azevedo	M	Mocambique	Manica	Inhambane	Mocambicana	D	1996-05-22	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	39	36	Superior	465315556745H
666	4313	Alice	Araújo	F	Mocambique	Cidade de Maputo	Cabo Delgado	Mocambicana	C	2004-01-24	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	55	51	Superior	379559103831C
667	4314	Benjamim	Faria	M	Mocambique	Sofala	Nampula	Mocambicana	S	1996-04-27	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	36	48	Superior	957269992650J
668	4315	Nelson	Barros	M	Mocambique	Tete	Maputo	Mocambicana	S	2005-11-11	Laboral	UP-Gurue	Escola Secundária da Maxixe	41	35	Superior	460729909774Q
669	4316	Kyara	Vieira	F	Mocambique	Maputo	Sofala	Mocambicana	S	2001-09-09	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	39	51	Superior	911366106709V
670	4317	Francisca	Simões	M	Mocambique	Tete	Sofala	Mocambicana	C	2003-10-10	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	48	68	Superior	542665794872K
671	4318	Iara	Carvalho	M	Mocambique	Inhambane	Zambézia	Mocambicana	C	1999-05-21	Laboral	UP-Massinga	Escola Secundária da Maxixe	60	53	Superior	778879698095R
672	4319	Lia	Andrade	F	Mocambique	Niassa	Maputo	Mocambicana	V	2002-10-23	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	64	37	Superior	241130200063I
673	4320	Maria	Cardoso	F	Mocambique	Cidade de Maputo	Inhambane	Mocambicana	C	2001-10-14	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	39	56	Superior	637226113943E
674	4321	Lucas	Reis	F	Mocambique	Inhambane	Tete	Mocambicana	C	2002-07-01	Laboral	UP-Xai-Xai	Colegio Arco-iris	46	36	Superior	243347770911H
675	4322	Renato	Matos	M	Mocambique	Cabo Delgado	Zambézia	Mocambicana	S	2000-02-23	Laboral	UP-Lichinga	Instituto Pré-Universitário de Tete	58	59	Superior	263307441317Z
676	4323	Vasco	Batista	M	Mocambique	Niassa	Inhambane	Mocambicana	S	1999-01-01	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	53	48	Superior	190404108774F
677	4324	Diogo	Simões	F	Mocambique	Cabo Delgado	Nampula	Mocambicana	S	2004-07-02	Laboral	UP-Massinga	Escola Secundária da Maxixe	57	51	Superior	123076715969T
678	4325	Manuel	Abreu	F	Mocambique	Inhambane	Zambézia	Mocambicana	D	1995-06-24	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	49	63	Superior	927478679550K
679	4326	Benjamim	Vicente	M	Mocambique	Manica	Gaza	Mocambicana	V	2004-07-03	Laboral	UP-Gurue	Colegio Arco-iris	53	63	Superior	036723521472B
680	4327	Sofia	Teixeira	F	Mocambique	Cidade de Maputo	Tete	Mocambicana	V	1998-04-14	Pos-Laboral	UP-Quelimane	Escola Secundária da Maxixe	65	57	Superior	522084083998U
681	4328	Isabel	Melo	F	Mocambique	Cidade de Maputo	Tete	Mocambicana	D	2001-10-13	Laboral	UP-Massinga	Colegio Arco-iris	39	50	Superior	595610274325D
682	4329	Caetana	Rocha	F	Mocambique	Cidade de Maputo	Nampula	Mocambicana	S	2003-09-26	Pos-Laboral	UP-Quelimane	Instituto Pré-Universitário de Tete	57	58	Superior	788140436252X
683	4330	Vicente	Campos	F	Mocambique	Zambézia	Gaza	Mocambicana	D	2000-10-22	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	35	38	Superior	619826677086D
684	4331	Ângelo	Lopes	F	Mocambique	Gaza	Maputo	Mocambicana	D	2002-07-02	Laboral	UP-Quelimane	Escola Secundária da Maxixe	45	58	Superior	022287994948Q
685	4332	Inês	Paiva	F	Mocambique	Manica	Cabo Delgado	Mocambicana	D	2002-07-04	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	44	67	Superior	250141108294B
686	4333	Flor	Soares	F	Mocambique	Cabo Delgado	Sofala	Mocambicana	C	2002-12-06	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	46	53	Superior	210892017737E
687	4334	Alice	Mota	M	Mocambique	Gaza	Inhambane	Mocambicana	S	1996-04-10	Pos-Laboral	UP-Gurue	Escola Secundária da Maxixe	46	65	Superior	857311180607L
688	4335	João	Pinheiro	F	Mocambique	Zambézia	Nampula	Mocambicana	S	2004-10-19	Laboral	UP-Xai-Xai	Escola Secundária da Maxixe	60	53	Superior	002106723359R
689	4336	Luciana	Amorim	F	Mocambique	Cidade de Maputo	Zambézia	Mocambicana	D	2005-02-05	Pos-Laboral	UP-Lichinga	Colegio Arco-iris	45	36	Superior	519228844256V
690	4337	Santiago	Moreira	F	Mocambique	Manica	Nampula	Mocambicana	D	2000-04-07	Laboral	UP-Xai-Xai	Colegio Arco-iris	44	56	Superior	896575255093U
691	4338	Nicole	Carvalho	M	Mocambique	Maputo	Niassa	Mocambicana	S	1997-04-04	Pos-Laboral	UP-Massinga	Instituto Pré-Universitário de Tete	47	38	Superior	035866347493P
692	4339	Íris	Assunção	M	Mocambique	Nampula	Inhambane	Mocambicana	C	2002-05-24	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	48	65	Superior	351152306032E
693	4340	Luís	Magalhães	M	Mocambique	Cidade de Maputo	Sofala	Mocambicana	V	1997-04-30	Pos-Laboral	UP-Quelimane	Colegio Arco-iris	43	41	Superior	195105711746P
694	4341	Gil	Barbosa	F	Mocambique	Zambézia	Inhambane	Mocambicana	D	2005-10-27	Pos-Laboral	UP-Gurue	Colegio Arco-iris	51	63	Superior	772380373117X
695	4342	Alexandra	Loureiro	M	Mocambique	Inhambane	Cabo Delgado	Mocambicana	S	2006-03-21	Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	35	39	Superior	213691040095O
696	4343	Diana	Alves	M	Mocambique	Nampula	Maputo	Mocambicana	C	1999-01-18	Pos-Laboral	UP-Gurue	Instituto Pré-Universitário de Tete	54	61	Superior	177040257053J
697	4344	Carlota	Gonçalves	M	Mocambique	Manica	Tete	Mocambicana	D	2005-07-25	Pos-Laboral	UP-Xai-Xai	Colegio Arco-iris	50	43	Superior	421227467854K
698	4345	Marcos	Melo	M	Mocambique	Tete	Maputo	Mocambicana	S	2003-07-02	Laboral	UP-Quelimane	Colegio Arco-iris	58	49	Superior	889198941243U
699	4346	José	Mendes	F	Mocambique	Sofala	Maputo	Mocambicana	S	1995-06-08	Laboral	UP-Massinga	Escola Secundária da Maxixe	47	64	Superior	329197727580Q
700	4347	Íris	Esteves	F	Mocambique	Cidade de Maputo	Niassa	Mocambicana	C	1997-06-22	Pos-Laboral	UP-Massinga	Escola Secundária da Maxixe	35	60	Superior	142996103386Q
\.


--
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.curso (seq, codigo, ativo, descricao, regime_id, faculcod, codgr) FROM stdin;
35	CIV006	t	Engenharia Civil	1	3	20
36	ELE007	t	Engenharia Elétrica e Eletrónica	1	3	20
37	MEC008	t	Engenharia Mecânica	1	3	20
38	TEL009	t	Engenharia Informática e de Telecomunicações	1	3	20
39	QUI010	t	Engenharia Química	1	3	20
40	MIN011	t	Engenharia de Minas	1	3	20
41	AGR012	t	Engenharia Agronómica	1	5	20
42	FLO013	t	Engenharia Florestal	1	5	20
43	PET014	t	Engenharia de Petróleos	1	3	20
44	COMP015	t	Ciências da Computação	1	3	18
45	ENF016	t	Enfermagem	1	4	13
46	FAR017	t	Farmácia	1	4	13
47	NUT018	t	Nutrição	1	4	13
48	ODO019	t	Odontologia	1	4	13
49	BIO020	t	Biologia Aplicada	1	3	13
50	VET021	t	Medicina Veterinária	1	4	13
51	PSI022	t	Psicologia	2	6	14
52	EDU023	t	Ciências da Educação	2	6	14
53	MAT024	t	Ensino de Matemática	2	6	13
54	FIS025	t	Ensino de Física	2	6	13
55	GEO026	t	Ensino de Geografia	2	6	12
56	POR027	t	Ensino de Português	2	6	11
57	FIL028	t	Filosofia	2	6	14
58	ANT029	t	Antropologia	2	6	14
59	SOC030	t	Sociologia	2	6	14
60	CON031	t	Contabilidade e Auditoria	2	7	19
61	FIN032	t	Finanças	2	7	19
62	ADM033	t	Administração Pública	2	7	19
63	REL034	t	Relações Internacionais	2	7	19
64	ECO035	t	Economia	2	7	19
65	DES036	t	Design Gráfico	1	2	20
66	ART037	t	Artes Visuais	1	2	15
67	PLA038	t	Planeamento Físico	1	2	15
68	URB039	t	Urbanismo	1	2	20
\.


--
-- Data for Name: curso_disciplinas; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.curso_disciplinas (curso_id, disciplina_id) FROM stdin;
35	1
35	4
36	1
36	4
38	4
38	14
66	12
66	13
56	13
56	7
54	14
56	4
49	9
49	3
53	14
53	4
57	14
57	6
37	4
37	14
39	4
39	3
40	2
40	3
41	9
41	2
42	2
42	9
43	3
43	14
44	4
44	14
45	9
45	13
46	9
46	13
\.


--
-- Data for Name: delegacao; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.delegacao (delegid, designacao, abrev) FROM stdin;
1	UP-Sede	UP-Sede
2	UP-Gaza	UP-Gaza
3	UP-Massinga	UP-Massinga
4	UP-Nampula	UNIROVUMA
5	UP-Beira	UP-Beira
6	UP-Quelimane	UP-Quelimane
7	UP-Manica	UP-Manica
8	UP-Tete	UP-Tete
9	UP-Niassa	UP-Niassa
10	UP-Maxixe	UP-Montepuez
11	UP-Massinga	UP-Massinga
\.


--
-- Data for Name: disciplinas; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.disciplinas (id, coddisc, designacao, data, hora, horaentrada, ordem, subj) FROM stdin;
1	AF1	Aptidão Física I	2014-01-14	08:00:00	07:30:00	1	A1
2	GEO	Geografia	2014-01-14	10:30:00	10:00:00	2	G
3	QUI	Química	2014-01-14	14:00:00	13:30:00	3	Q
4	MAT	Matemática	2014-01-15	10:30:00	10:00:00	4	M
5	ING	Inglês	2014-01-15	08:00:00	07:30:00	5	I
6	FIL	Fund.Filosofia	2014-01-14	08:00:00	07:30:00	6	Fu
7	HIS	História	2014-01-16	14:00:00	13:30:00	7	H
8	AF2	Aptidão Física II	2014-01-17	08:00:00	07:30:00	8	A2
9	BIO	Biologia	2014-01-16	10:30:00	10:00:00	9	B
10	BEF	Biologia (E.Fisica)	2012-01-13	10:30:00	10:00:00	10	Be
11	FRA	Francês	2014-01-16	08:00:00	07:30:00	11	Fr
12	DES	Aptidão em Desenho	2014-01-14	08:00:00	07:30:00	12	D
13	POR	Português	2014-01-17	10:30:00	10:00:00	13	P
14	FIS	Física	2014-01-17	08:00:00	07:30:00	14	Fi
\.


--
-- Data for Name: escolapreu; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.escolapreu (codesc, designacao, provid) FROM stdin;
0	Escola Francisco Manyanga	2
1	Escola Josina Machael	1
2	Instituto industrial de Maputo	1
3	Colegio Arco-iris	1
4	Instituto Comercial da Matola	1
5	ES Malangatana	1
6	Escola Secundaria de Napipine	3
7	Desconhecido	13
8	Desconhecido	13
9	Desconhecido	13
10	Desconhecido	13
11	Desconhecido	13
\.


--
-- Data for Name: faculdade; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.faculdade (cod, designacao, abrev) FROM stdin;
1	Faculdade de Direito	FD
2	Faculdade de Arquitectura e Planeamento Físico	FAPF
3	Faculdade de Ciências	FC
4	Faculdade de Ciências da Saúde	FCS
5	Faculdade de Agronomia e Engenharia Florestal	FAEF
6	Faculdade de Educação	FE
7	Faculdade de Economia e Gestão	FEG
8	Faculdade de Artes e Design	FAD
9	Faculdade de Ciências Sociais e Humanas	FCSH
\.


--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.grupos (gr, codgr, designacao) FROM stdin;
1	11	LINGUAS
2	12	CiENCIAS SOCIAIS
3	13	CIENCIAS NATURAIS E MATEMATICA
4	14	CIENCIAS DE EDUCAÇÃO E PSICOLOGIA
5	15	EDUCAÇAO FISICA E DESPORTO
6	16	12ª +1
7	17	Pós-Laboral
8	18	TECNOLOGIAS
9	19	GESTÃO
10	20	ENGENHARIAS
\.


--
-- Data for Name: localidade; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.localidade (provid, designacao) FROM stdin;
1	Cidade de Maputo
2	Manica
3	Nampula
5	Sofala
6	Tete
7	Inhambane
8	Gaza
9	Maxixe
10	Cabo Delgado
11	Maputo Provincia
12	Niassa
13	Desconhecida
4	Zambézia
\.


--
-- Data for Name: regime; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.regime (id, nome, descricao) FROM stdin;
1	Laboral	Período diurno
2	Pos-Laboral	Período noturno
3	E-Distancia	Ensino a distância
\.


--
-- Data for Name: sala_candidato; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.sala_candidato (id, provincia, nrcandidato, nome, opcao1, opcao2, disciplina, local, sala) FROM stdin;
\.


--
-- Data for Name: salas; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.salas (salaid, local, nrsala, provincia, prioridade, ordem, capacidade, nrvigilante, emuso) FROM stdin;
2	UP - Sede	Sala 10	1	1	2	35	1	f
3	UP - Sede	Sala 11	1	1	3	35	1	f
4	UP - Sede	Sala 12	1	2	4	0	1	f
5	UP - Sede	Sala 30	1	1	5	35	1	f
6	UP - Sede	Sala 15	1	2	6	30	1	f
7	UP - Sede	Sala 16	1	2	7	30	1	f
8	UP - Sede	Sala 28	1	2	8	35	1	f
9	UP - Sede	Sala 27	1	2	9	35	1	f
10	UP - Sede	Sala 29	1	2	10	30	1	f
11	UP - Sede	Editora B	1	1	11	30	1	f
12	UP - Sede	Anfiteatro C	1	1	12	0	4	f
13	UP - Sede	Anfiteatro A	1	1	13	150	4	f
14	UP - Sede	Anfiteatro B	1	1	14	150	4	f
1	UP - Sede	Editora A	1	1	1	30	1	t
\.


--
-- Name: candidato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.candidato_id_seq', 700, true);


--
-- Name: curso_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.curso_seq_seq', 68, true);


--
-- Name: delegacao_delegid_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.delegacao_delegid_seq', 11, true);


--
-- Name: disciplinas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.disciplinas_id_seq', 14, true);


--
-- Name: faculdade_cod_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.faculdade_cod_seq', 1, false);


--
-- Name: grupos_gr_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.grupos_gr_seq', 10, true);


--
-- Name: localidade_provid_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.localidade_provid_seq', 13, true);


--
-- Name: regime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.regime_id_seq', 3, true);


--
-- Name: sala_candidato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.sala_candidato_id_seq', 739, true);


--
-- Name: salas_salaid_seq; Type: SEQUENCE SET; Schema: public; Owner: maulate
--

SELECT pg_catalog.setval('public.salas_salaid_seq', 14, true);


--
-- Name: candidato candidato_nrcandidato_key; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.candidato
    ADD CONSTRAINT candidato_nrcandidato_key UNIQUE (nrcandidato);


--
-- Name: curso curso_codigo_key; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_codigo_key UNIQUE (codigo);


--
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (seq);


--
-- Name: disciplinas disciplinas_coddisc_key; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplinas_coddisc_key UNIQUE (coddisc);


--
-- Name: disciplinas disciplinas_pkey; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplinas_pkey PRIMARY KEY (id);


--
-- Name: candidato nk_cand; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.candidato
    ADD CONSTRAINT nk_cand UNIQUE (nrcandidato, nome);


--
-- Name: candidato pk_cand; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.candidato
    ADD CONSTRAINT pk_cand PRIMARY KEY (id, nrcandidato);


--
-- Name: curso_disciplinas pk_curdis; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso_disciplinas
    ADD CONSTRAINT pk_curdis PRIMARY KEY (curso_id, disciplina_id);


--
-- Name: delegacao pk_delegacao; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.delegacao
    ADD CONSTRAINT pk_delegacao PRIMARY KEY (delegid);


--
-- Name: escolapreu pk_esc; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.escolapreu
    ADD CONSTRAINT pk_esc PRIMARY KEY (codesc);


--
-- Name: faculdade pk_facul; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.faculdade
    ADD CONSTRAINT pk_facul PRIMARY KEY (cod);


--
-- Name: grupos pk_gr; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT pk_gr PRIMARY KEY (codgr);


--
-- Name: localidade pk_local; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.localidade
    ADD CONSTRAINT pk_local PRIMARY KEY (provid);


--
-- Name: regime regime_nome_key; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.regime
    ADD CONSTRAINT regime_nome_key UNIQUE (nome);


--
-- Name: regime regime_pkey; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.regime
    ADD CONSTRAINT regime_pkey PRIMARY KEY (id);


--
-- Name: sala_candidato sala_candidato_pkey; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.sala_candidato
    ADD CONSTRAINT sala_candidato_pkey PRIMARY KEY (id);


--
-- Name: salas salas_pkey; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.salas
    ADD CONSTRAINT salas_pkey PRIMARY KEY (salaid);


--
-- Name: salas unique_sala; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.salas
    ADD CONSTRAINT unique_sala UNIQUE (nrsala);


--
-- Name: curso_disciplinas fk_curdi; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso_disciplinas
    ADD CONSTRAINT fk_curdi FOREIGN KEY (disciplina_id) REFERENCES public.disciplinas(id) ON DELETE CASCADE;


--
-- Name: curso_disciplinas fk_dicur; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso_disciplinas
    ADD CONSTRAINT fk_dicur FOREIGN KEY (curso_id) REFERENCES public.curso(seq) ON DELETE CASCADE;


--
-- Name: escolapreu fk_esc; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.escolapreu
    ADD CONSTRAINT fk_esc FOREIGN KEY (provid) REFERENCES public.localidade(provid);


--
-- Name: curso fk_fd; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT fk_fd FOREIGN KEY (faculcod) REFERENCES public.faculdade(cod);


--
-- Name: curso fk_gr; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT fk_gr FOREIGN KEY (codgr) REFERENCES public.grupos(codgr);


--
-- Name: curso fk_regime; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT fk_regime FOREIGN KEY (regime_id) REFERENCES public.regime(id);


--
-- Name: sala_candidato sala_fk; Type: FK CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.sala_candidato
    ADD CONSTRAINT sala_fk FOREIGN KEY (sala) REFERENCES public.salas(nrsala);


--
-- PostgreSQL database dump complete
--

