/********************************************I-DAT-JRR-EJE-1-04/08/2016********************************************/

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (E'EJE', E'Ejemplo', E'2016-08-02', E'EJE', E'activo', E'ejemplo', NULL);

----------------------------------
--COPY LINES TO data.sql FILE
---------------------------------

select pxp.f_insert_tgui ('EJEMPLO', '', 'EJE', 'si', 1, '', 1, '', '', 'EJE');
select pxp.f_insert_tgui ('Persona', 'Persona', 'EJEPER', 'si', 1, 'sis_ejemplo/vista/persona/Persona.php', 2, '', 'Persona', 'EJE');
----------------------------------
--COPY LINES TO dependencies.sql FILE
---------------------------------

select pxp.f_insert_testructura_gui ('EJE', 'SISTEMA');
select pxp.f_insert_testructura_gui ('EJEPER', 'EJE');

/********************************************F-DAT-JRR-EJE-1-04/08/2016********************************************/