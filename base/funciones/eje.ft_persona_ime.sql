CREATE OR REPLACE FUNCTION "eje"."ft_persona_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Ejemplo
 FUNCION: 		eje.ft_persona_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'eje.tpersona'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_persona	integer;
			    
BEGIN

    v_nombre_funcion = 'eje.ft_persona_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'EJE_PER_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-08-2016 18:57:02
	***********************************/

	if(p_transaccion='EJE_PER_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into eje.tpersona(
			estado_reg,
			nombre,
			apellido_paterno,
			apellido_materno,
			fecha_reg,
			id_usuario_reg,
			usuario_ai,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.apellido_paterno,
			v_parametros.apellido_materno,
			now(),
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_persona into v_id_persona;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona almacenado(a) con exito (id_persona'||v_id_persona||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_id_persona::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'EJE_PER_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-08-2016 18:57:02
	***********************************/

	elsif(p_transaccion='EJE_PER_MOD')then

		begin
			--Sentencia de la modificacion
			update eje.tpersona set
			nombre = v_parametros.nombre,
			apellido_paterno = v_parametros.apellido_paterno,
			apellido_materno = v_parametros.apellido_materno,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_persona=v_parametros.id_persona;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_parametros.id_persona::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'EJE_PER_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-08-2016 18:57:02
	***********************************/

	elsif(p_transaccion='EJE_PER_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from eje.tpersona
            where id_persona=v_parametros.id_persona;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_persona',v_parametros.id_persona::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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
ALTER FUNCTION "eje"."ft_persona_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
