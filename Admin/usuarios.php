<?php
$ValidarUsuarioSesionEsAdmin = 1; // Este es un parámetro que recibe "ValidarIngresoApp.php"
include_once "ValidarIngresoApp.php"; // Aquí dentro se hace el redireccionamiento a la página de ingreso, en caso de fallar la validación
// La anterior debe ser la primera instrucción por ejecutar en el archivo web

include_once "CParametrosGet.php";
$TextoXBuscar = CParametrosGet::DemeTextoXBuscar("TextoXBuscar", "usuarios.php");

// A continuación el código fuente de la implementación
try
{
    include_once "CUsuarios.php";
    $Usuarios = new CUsuarios();
    $ListadoUsuarios = $Usuarios->ConsultarXTodosUsuarios($TextoXBuscar);
} // try
catch (Exception $e)
{
    $NumError = 1;
    $MensajeOtroError = $e->getMessage();
} // catch (Exception $e)
// El anterior fue el código fuente de la implementación

include "interfaz/usuarios.php";
?>
