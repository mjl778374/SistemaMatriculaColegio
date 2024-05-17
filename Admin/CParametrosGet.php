<?php
include_once "CNumeros.php";

class CParametrosGet
{
    public static function DemeNumPagina($ParametroGet, $NumPaginas, $IdFormulario)
    {
        $NumPagina = 1;
        $ParametroSession = $IdFormulario . "_" . $ParametroGet;
        unset($ValorParametro);
        
        if ($_SERVER["REQUEST_METHOD"] == "POST")
            unset($_SESSION[$ParametroSession]);
        
	if (isset($_GET[$ParametroGet]))
            $ValorParametro = $_GET[$ParametroGet];
        
        else if (isset($_SESSION[$ParametroSession]))
            $ValorParametro = $_SESSION[$ParametroSession];
            
        if (isset($ValorParametro) && CNumeros::EsNumeroEntero($ValorParametro) && $ValorParametro > 0)
            $NumPagina = intval($ValorParametro, 10);

        if ($NumPagina > $NumPaginas)
            $NumPagina = $NumPaginas;

	$ValorParametro = $NumPagina;
	$_SESSION[$ParametroSession] = $ValorParametro;
        return $NumPagina;
    } // public static function DemeNumPagina($ParametroGet, $NumPaginas, $IdFormulario)

    public static function DemeTextoXBuscar($ParametroGet, $IdFormulario)
    {
    	$TextoXBuscar = "";
    	$ParametroSession = $IdFormulario . "_" . $ParametroGet;

	if (isset($_GET[$ParametroGet]))
    	    $TextoXBuscar = $_GET[$ParametroGet];
    	    
	elseif (isset($_SESSION[$ParametroSession]))
            $TextoXBuscar = $_SESSION[$ParametroSession];

	$_SESSION[$ParametroSession] = $TextoXBuscar;
	return $TextoXBuscar;
    } // public static function DemeTextoXBuscar($ParametroGet, $IdFormulario)
    
    public static function ValidarModo($ParametroGet, &$NumError)
    {
        include "constantesApp.php";
        $Retornar = "";
        $NumError = 0;

        if (!isset($_GET[$ParametroGet]))
            $NumError = 1;

        elseif (strcmp($_GET[$ParametroGet], $MODO_ALTA) != 0 && strcmp($_GET[$ParametroGet], $MODO_CAMBIO) != 0)
            $NumError = 2;

        else
            $Retornar = $_GET[$ParametroGet];

        return $Retornar;
    } // public static function ValidarModo($ParametroGet, $NumError)

    public static function ValidarIdEntero($ParametroGet, &$NumError)
    {
        $Retornar = 0;
        $NumError = 0;

        if (!isset($_GET[$ParametroGet]))
            $NumError = 1;

        elseif (!CNumeros::EsNumeroEntero($_GET[$ParametroGet]) || $_GET[$ParametroGet] < 0)
            $NumError = 2;

        else
            $Retornar = intval($_GET[$ParametroGet], 10);

        return $Retornar;
    } // public static function ValidarIdEntero($ParametroGet, &$NumError)
} // class CParametrosGet
?>
