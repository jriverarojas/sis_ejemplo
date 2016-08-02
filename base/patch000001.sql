/********************************************I-SCP-JRR-EJE-1-04/08/2016********************************************/
CREATE TABLE eje.tpersona (
  id_persona SERIAL,
  nombre VARCHAR(100) NOT NULL,
  apellido_paterno VARCHAR(100) NOT NULL,
  apellido_materno VARCHAR(100) NOT NULL,
  CONSTRAINT tpersona_pkey PRIMARY KEY(id_persona)
) INHERITS (pxp.tbase)

WITH (oids = false);

/********************************************F-SCP-JRR-EJE-1-04/08/2016********************************************/