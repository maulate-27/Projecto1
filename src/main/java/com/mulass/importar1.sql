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
    nome character varying(15) NOT NULL,
    idade integer,
    nacionalidade character varying(100),
    morada character varying(100),
    email character varying(100) DEFAULT '@gmail.com'::character varying
);


ALTER TABLE public.candidato OWNER TO maulate;

--
-- Data for Name: candidato; Type: TABLE DATA; Schema: public; Owner: maulate
--

COPY public.candidato (id, nome, idade, nacionalidade, morada, email) FROM stdin;
1	Maulate	19	Mocambicana	paris	maulateant34@gmail.com
3	Yasmine	2	Francesa	paris	yasmada@gmail.com
2	Daniela	16	Irlandesa	Argentina	danimau@gmail.com
\.


--
-- Name: candidato pk_candi; Type: CONSTRAINT; Schema: public; Owner: maulate
--

ALTER TABLE ONLY public.candidato
    ADD CONSTRAINT pk_candi PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

