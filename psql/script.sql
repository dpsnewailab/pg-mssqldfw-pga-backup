-- create table

CREATE TABLE public.default_table
(
    id bigserial,
    name character varying(63),
    PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.default_table
    OWNER to admin;


INSERT INTO public.default_table(name) VALUES('Donald Trump');
INSERT INTO public.default_table(name) VALUES('Xi Jinping');
INSERT INTO public.default_table(name) VALUES('Martin Luther King, Jr.');