<?php
/**
*@package pXP
*@file gen-ACTPersona.php
*@author  (admin)
*@date 02-08-2016 18:57:02
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPersona extends ACTbase{    
			
	function listarPersona(){
		$this->objParam->defecto('ordenacion','id_persona');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPersona','listarPersona');
		} else{
			$this->objFunc=$this->create('MODPersona');
			
			$this->res=$this->objFunc->listarPersona($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPersona(){
		$this->objFunc=$this->create('MODPersona');	
		if($this->objParam->insertar('id_persona')){
			$this->res=$this->objFunc->insertarPersona($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPersona($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPersona(){
			$this->objFunc=$this->create('MODPersona');	
		$this->res=$this->objFunc->eliminarPersona($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>