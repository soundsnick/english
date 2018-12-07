--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Ubuntu 10.5-1.pgdg18.04+1)
-- Dumped by pg_dump version 10.5 (Ubuntu 10.5-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO yernazar;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    title character varying
);


ALTER TABLE public.categories OWNER TO yernazar;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: yernazar
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO yernazar;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yernazar
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO yernazar;

--
-- Name: users; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying,
    password character varying,
    name character varying,
    avatar character varying,
    role integer,
    balance integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO yernazar;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: yernazar
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO yernazar;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yernazar
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.videos (
    id bigint NOT NULL,
    title character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    file character varying,
    thumb character varying,
    category_id integer
);


ALTER TABLE public.videos OWNER TO yernazar;

--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: yernazar
--

CREATE SEQUENCE public.videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_id_seq OWNER TO yernazar;

--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yernazar
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2018-10-05 01:20:43.741687	2018-10-05 01:20:43.741687
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.categories (id, title) FROM stdin;
1	Grammar
2	Vocabulary
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.schema_migrations (version) FROM stdin;
20181005011543
20181101204557
20181101204730
20181101205129
20181101212808
20181101225122
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.users (id, email, password, name, avatar, role, balance, created_at, updated_at) FROM stdin;
1	soundsnick@gmail.com	123456	Yernazar	oavatar.png	1	\N	2018-10-05 01:24:34.520028	2018-10-05 01:24:34.520028
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.videos (id, title, description, created_at, updated_at, file, thumb, category_id) FROM stdin;
2	Adele - Hello	Hello world	2018-11-01 21:39:40.200693	2018-11-01 21:39:40.200693	demsos.mkv	1005x558_20170505105633a0ac078303.png	1
3	Charlie Puth - Attention	Hello world	2018-11-01 21:40:28.651608	2018-11-01 21:40:28.651608	demsos.mkv	908618.jpg	1
4	Adele - Rolling in the deep	...	2018-11-01 21:41:24.483462	2018-11-01 21:41:24.483462	demsos.mkv	adele.jpg	1
5	Adele - Rolling in the deep	...	2018-11-01 21:43:31.279843	2018-11-01 21:43:31.279843	demsos.mkv	adele-press-bw-2016-billboard-1548.jpg	1
6	Charlie Puth - Marvin Gaye	...	2018-11-01 21:44:44.868063	2018-11-01 21:44:44.868063	demsos.mkv	og-image.png	1
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.videos_id_seq', 6, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

