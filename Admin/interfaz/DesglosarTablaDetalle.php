<?php
if ($NumPaginaActual > 0)
{
    $Filas = [];
    $IndiceInicial = ($NumPaginaActual - 1) * $MAX_NUM_RESULTADOS_X_PAGINA;
    $IndiceFinal = $IndiceInicial + $MAX_NUM_RESULTADOS_X_PAGINA - 1;

    if ($IndiceFinal >= count($ListadoDatos))
        $IndiceFinal = count($ListadoDatos) - 1;

    for ($i = $IndiceInicial; $i <= $IndiceFinal; $i++)
    {
        $ObjDatos = $ListadoDatos[$i];
        
        if ($i == $IndiceInicial)
       	{
            $EncabezadoTabla = $ObjDatos->DemeTitulares();
            $TargetLinks = $ObjDatos->DemeTargetLinks();
            $Alineamientos = $ObjDatos->DemeAlineamientos();
            $IncluirLinkPrimeraColumna = $ObjDatos->IncluirLinkPrimeraColumna();
       	} // if ($i == $IndiceInicial)
            
        $Filas[] = $ObjDatos->DemeArregloDatos();
        // $EncabezadoTabla, $TargetLinks, $Alineamientos, $IncluirLinkPrimeraColumna y $Filas son parámetros que recibe "componenteTablaDetalle.php"
    } // for ($i = $IndiceInicial; $i <= $IndiceFinal; $i++)

    if (count($Filas) > 0)
        include "componenteTablaDetalle.php";
} // if ($NumPaginaActual > 0)

