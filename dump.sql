--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

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
-- Name: courses; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    title character varying,
    description text,
    cover character varying,
    price integer,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.courses OWNER TO yernazar;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: yernazar
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO yernazar;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yernazar
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO yernazar;

--
-- Name: user_courses; Type: TABLE; Schema: public; Owner: yernazar
--

CREATE TABLE public.user_courses (
    id bigint NOT NULL,
    user_id integer,
    course_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_courses OWNER TO yernazar;

--
-- Name: user_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: yernazar
--

CREATE SEQUENCE public.user_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_courses_id_seq OWNER TO yernazar;

--
-- Name: user_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yernazar
--

ALTER SEQUENCE public.user_courses_id_seq OWNED BY public.user_courses.id;


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
    course_id integer
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
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: user_courses id; Type: DEFAULT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.user_courses ALTER COLUMN id SET DEFAULT nextval('public.user_courses_id_seq'::regclass);


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
environment	development	2020-01-17 08:25:44.753954	2020-01-17 08:25:44.753954
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.categories (id, title) FROM stdin;
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.courses (id, title, description, cover, price, category_id, created_at, updated_at) FROM stdin;
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
20181207210151
20181207210504
20181207225650
\.


--
-- Data for Name: user_courses; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.user_courses (id, user_id, course_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.users (id, email, password, name, avatar, role, balance, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: yernazar
--

COPY public.videos (id, title, description, created_at, updated_at, file, thumb, course_id) FROM stdin;
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.courses_id_seq', 1, false);


--
-- Name: user_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.user_courses_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yernazar
--

SELECT pg_catalog.setval('public.videos_id_seq', 1, false);


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
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_courses user_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: yernazar
--

ALTER TABLE ONLY public.user_courses
    ADD CONSTRAINT user_courses_pkey PRIMARY KEY (id);


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

