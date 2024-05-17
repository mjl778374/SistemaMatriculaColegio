<?php
$ValidarUsuarioSesionEsAdmin = 1; // Este es un parámetro que recibe "ValidarIngresoApp.php"
include_once "ValidarIngresoApp.php"; // Aquí dentro se hace el redireccionamiento a la página de ingreso, en caso de fallar la validación
// La anterior debe ser la primera instrucción por ejecutar en el archivo web

$SeDebeIndexarTodo = false;
$MensajesXDesglosar = [];
$MENSAJE_OK = 1;
$MENSAJE_ERROR = 2;

$ID_MENSAJE_SE_VAN_INDEXAR_TODOS_USUARIOS = 1;
$ID_MENSAJE_SE_INDEXARON_TODOS_USUARIOS = 2;

$ID_MENSAJE_SE_INDEXO_TODO_EXITOSAMENTE = 0;

if ($_SERVER["REQUEST_METHOD"] == "POST")
{
    $SeDebeIndexarTodo = true;
} // if ($_SERVER["REQUEST_METHOD"] == "POST")

// A continuación el código fuente de la implementación
try
{
    if ($SeDebeIndexarTodo)
    {
        $MensajesXDesglosar[] = array($MENSAJE_OK, $ID_MENSAJE_SE_VAN_INDEXAR_TODOS_USUARIOS);
        include_once "CUsuarios.php";
        $Usuarios = new CUsuarios();
        $Usuarios->IndexarTodo();
        $MensajesXDesglosar[] = array($MENSAJE_OK, $ID_MENSAJE_SE_INDEXARON_TODOS_USUARIOS);

        $MensajesXDesglosar[] = array($MENSAJE_OK, $ID_MENSAJE_SE_INDEXO_TODO_EXITOSAMENTE);
    } // if ($SeDebeIndexarTodo)
} // try
catch (Exception $e)
{
    $MensajesXDesglosar[] = array($MENSAJE_ERROR, $e->getMessage());
} // catch (Exception $e)
// El anterior fue el código fuente de la implementación

include "interfaz/indexarTodo.php";
?>
