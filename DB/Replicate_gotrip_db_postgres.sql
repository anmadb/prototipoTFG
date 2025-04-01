--
-- PostgreSQL database dump
--

-- Dumped from database version 17.3
-- Dumped by pg_dump version 17.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: Friendship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Friendship" (
    id bigint NOT NULL,
    "user-id" bigint NOT NULL,
    "friend-id" bigint NOT NULL,
    created_at date NOT NULL
);


ALTER TABLE public."Friendship" OWNER TO postgres;

--
-- Name: Messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Messages" (
    id bigint NOT NULL,
    message text NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    "emisor-id" bigint NOT NULL,
    "receptor-id" bigint NOT NULL
);


ALTER TABLE public."Messages" OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO postgres;

--
-- Name: Posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Posts" (
    id bigint DEFAULT nextval('public.posts_id_seq'::regclass) NOT NULL,
    "user-id" bigint NOT NULL,
    img character varying(255) NOT NULL,
    description text NOT NULL,
    "geoCode" double precision[] NOT NULL,
    created_at date NOT NULL
);


ALTER TABLE public."Posts" OWNER TO postgres;

--
-- Name: Reactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reactions" (
    id bigint NOT NULL,
    "user-id" bigint NOT NULL,
    "post-id" bigint NOT NULL,
    "type_reaction-id" bigint NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public."Reactions" OWNER TO postgres;

--
-- Name: TypeOfReactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TypeOfReactions" (
    id bigint NOT NULL,
    type_reaction character varying(50) NOT NULL
);


ALTER TABLE public."TypeOfReactions" OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id bigint DEFAULT nextval('public.users_id_seq'::regclass) NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    avatar character varying(255) NOT NULL,
    bio text,
    created_at date NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Data for Name: Friendship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Friendship" (id, "user-id", "friend-id", created_at) FROM stdin;
\.


--
-- Data for Name: Messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Messages" (id, message, created_at, "emisor-id", "receptor-id") FROM stdin;
\.


--
-- Data for Name: Posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Posts" (id, "user-id", img, description, "geoCode", created_at) FROM stdin;
4	4	4.jpg	Caminando por las calles de París, la ciudad del amor y la luz. ¡Cada rincón es una obra de arte! #Viajes #París	{48.8566,2.3522}	2025-02-14
1	1	1.avif	Disfrutando de las vistas icónicas de la ciudad de Nueva York. ¡El skyline es impresionante! #Viajes #NuevaYork	{40.7128,-74.006}	2025-02-14
2	2	2.jpg	Explorando las calles de Los Ángeles y su vibrante escena artística. ¡Qué ciudad tan inspiradora! #Viajes #LosAngeles	{34.0522,-118.2437}	2025-02-14
3	3	3.jpg	Paseando por Londres y descubriendo su rica historia y cultura. ¡Una experiencia inolvidable! #Viajes #Londres	{51.5074,-0.1278}	2025-02-14
5	5	5.webp	Descubriendo la energía y los colores de la Ciudad de México. ¡Una ciudad llena de vida y cultura! #Viajes #CDMX	{19.4326,-99.1332}	2025-02-14
\.


--
-- Data for Name: Reactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reactions" (id, "user-id", "post-id", "type_reaction-id", created_at) FROM stdin;
\.


--
-- Data for Name: TypeOfReactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TypeOfReactions" (id, type_reaction) FROM stdin;
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, username, email, password, avatar, bio, created_at) FROM stdin;
1	juanperez	juan.perez@mail.com	hashed_password1	juan_avatar.png	Apasionado por la fotografía y la tecnología.	2025-02-14
2	maria_lopez	maria.lopez@mail.com	hashed_password2	maria_avatar.png	Diseñadora gráfica y amante del café.	2025-02-14
3	carlosgomez	carlos.gomez@mail.com	hashed_password3	carlos_avatar.png	Jugador de ajedrez y programador backend.	2025-02-14
4	lucia_rodriguez	lucia.rodriguez@mail.com	hashed_password4	lucia_avatar.png	Fan del cine clásico y la literatura.	2025-02-14
5	diego_fernandez	diego.fernandez@mail.com	hashed_password5	diego_avatar.png	Guitarrista aficionado y viajero frecuente.	2025-02-14
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 5, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: Friendship Friendship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Friendship"
    ADD CONSTRAINT "Friendship_pkey" PRIMARY KEY (id);


--
-- Name: Messages Messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id);


--
-- Name: Posts Posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posts"
    ADD CONSTRAINT "Posts_pkey" PRIMARY KEY (id);


--
-- Name: Reactions Reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT "Reactions_pkey" PRIMARY KEY (id);


--
-- Name: TypeOfReactions TypeOfReactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TypeOfReactions"
    ADD CONSTRAINT "TypeOfReactions_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Friendship friendship_friend_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Friendship"
    ADD CONSTRAINT friendship_friend_id_unique UNIQUE ("friend-id");


--
-- Name: Friendship friendship_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Friendship"
    ADD CONSTRAINT friendship_user_id_unique UNIQUE ("user-id");


--
-- Name: Messages messages_emisor_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT messages_emisor_id_unique UNIQUE ("emisor-id");


--
-- Name: Messages messages_receptor_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT messages_receptor_id_unique UNIQUE ("receptor-id");


--
-- Name: Reactions reactions_post_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT reactions_post_id_unique UNIQUE ("post-id");


--
-- Name: Reactions reactions_type_reaction_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT reactions_type_reaction_id_unique UNIQUE ("type_reaction-id");


--
-- Name: Reactions reactions_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT reactions_user_id_unique UNIQUE ("user-id");


--
-- Name: TypeOfReactions typeofreactions_type_reaction_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TypeOfReactions"
    ADD CONSTRAINT typeofreactions_type_reaction_unique UNIQUE (type_reaction);


--
-- Name: Users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: Users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: messages_message_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_message_index ON public."Messages" USING btree (message);


--
-- Name: posts_description_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX posts_description_index ON public."Posts" USING btree (description);


--
-- Name: posts_geocode_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX posts_geocode_index ON public."Posts" USING btree ("geoCode");


--
-- Name: posts_img_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX posts_img_index ON public."Posts" USING btree (img);


--
-- Name: users_avatar_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_avatar_index ON public."Users" USING btree (avatar);


--
-- Name: users_bio_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_bio_index ON public."Users" USING btree (bio);


--
-- Name: users_password_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_password_index ON public."Users" USING btree (password);


--
-- Name: Friendship friendship_friend_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Friendship"
    ADD CONSTRAINT friendship_friend_id_foreign FOREIGN KEY ("friend-id") REFERENCES public."Users"(id);


--
-- Name: Friendship friendship_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Friendship"
    ADD CONSTRAINT friendship_user_id_foreign FOREIGN KEY ("user-id") REFERENCES public."Users"(id);


--
-- Name: Messages messages_emisor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT messages_emisor_id_foreign FOREIGN KEY ("emisor-id") REFERENCES public."Users"(id);


--
-- Name: Messages messages_receptor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT messages_receptor_id_foreign FOREIGN KEY ("receptor-id") REFERENCES public."Users"(id);


--
-- Name: Posts posts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posts"
    ADD CONSTRAINT posts_user_id_foreign FOREIGN KEY ("user-id") REFERENCES public."Users"(id);


--
-- Name: Reactions reactions_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT reactions_post_id_foreign FOREIGN KEY ("post-id") REFERENCES public."Posts"(id);


--
-- Name: Reactions reactions_type_reaction_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT reactions_type_reaction_id_foreign FOREIGN KEY ("type_reaction-id") REFERENCES public."TypeOfReactions"(id);


--
-- Name: Reactions reactions_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reactions"
    ADD CONSTRAINT reactions_user_id_foreign FOREIGN KEY ("user-id") REFERENCES public."Users"(id);


--
-- PostgreSQL database dump complete
--

