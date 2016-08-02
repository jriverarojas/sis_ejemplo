CREATE OR REPLACE FUNCTION "eje"."ft_persona_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Ejemplo
 FUNCION: 		eje.ft_persona_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'eje.tpersona'
 AUTOR: 		 (admin)
 FECHA:	        02-08-2016 18:57:02
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'eje.ft_persona_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'EJE_PER_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		02-08-2016 18:57:02
	***********************************/

	if(p_transaccion='EJE_PER_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						per.id_persona,
						per.estado_reg,
						per.nombre,
						per.apellido_paterno,
						per.apellido_materno,
						per.fecha_reg,
						per.id_usuario_reg,
						per.usuario_ai,
						per.id_usuario_ai,
						per.fecha_mod,
						per.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from eje.tpersona per
						inner join segu.tusuario usu1 on usu1.id_usuario = per.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = per.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'EJE_PER_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		02-08-2016 18:57:02
	***********************************/

	elsif(p_transaccion='EJE_PER_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_persona)
					    from eje.tpersona per
					    inner join segu.tusuario usu1 on usu1.id_usuario = per.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = per.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "eje"."ft_persona_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
