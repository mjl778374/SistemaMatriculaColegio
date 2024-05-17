<?php
if ($SeGuardoInformacionExitosamente && strcmp($Modo, $MODO_ALTA) == 0)
{    
    echo "<script>window.location.href = 'usuario.php?Modo=" . $MODO_CAMBIO . "&IdUsuario=" . $IdUsuario . "';</script>"; // Se carga el usuario guardado.
    exit;
} // if ($SeGuardoInformacionExitosamente && strcmp($Modo, $MODO_ALTA) == 0)

include_once "CFormateadorMensajes.php";
include_once "CPalabras.php";

$ErrorNoExisteUsuarioConIdEspecificado = "No existe el usuario con el id " . $IdUsuario . ".";
$ErrorUsuarioInvalido = "El usuario debe tener al menos un caracter y solo debe componerse de los siguientes " . CPalabras::DemeCaracteresValidos();
$ErrorCedulaInvalida = "La cédula debe tener al menos uno de los siguientes caracteres " . CPalabras::DemeCaracteresValidos();
$ErrorNombreInvalido = "El nombre debe tener al menos uno de los siguientes caracteres " . CPalabras::DemeCaracteresValidos();

if ($NumError != 0)
{
    $MensajeXFormatear = "";

    if ($NumError == 1)
        $MensajeXFormatear = $MensajeOtroError;
    elseif ($NumError == 2)
        $MensajeXFormatear = $ErrorNoExisteUsuarioConIdEspecificado;
    else
    {
        if (strcmp($Modo, $MODO_ALTA) == 0)
        {
            if ($NumError == 1001)
                $MensajeXFormatear = "Ya existe el usuario " . $Usuario . ". No se puede insertar nuevamente.";
            elseif ($NumError == 2001)
                $MensajeXFormatear = $ErrorUsuarioInvalido;
            elseif ($NumError == 2002)
                $MensajeXFormatear = $ErrorCedulaInvalida;
            elseif ($NumError == 2003)
                $MensajeXFormatear = $ErrorNombreInvalido;
            elseif ($NumError != 0)
                $MensajeXFormatear = "No se manejó el error número " . $NumError . " en el proceso 'AltaUsuario'.";
        } // if (strcmp($Modo, $MODO_ALTA) == 0)

        elseif (strcmp($Modo, $MODO_CAMBIO) == 0)
        {
            if ($NumError == 1001)
                $MensajeXFormatear = "Ya existe el usuario " . $Usuario . " con otro id.";
            elseif ($NumError == 2001)
                $MensajeXFormatear = $ErrorNoExisteUsuarioConIdEspecificado;
            elseif ($NumError == 3001)
                $MensajeXFormatear = $ErrorUsuarioInvalido;
            elseif ($NumError == 3002)
                $MensajeXFormatear = $ErrorCedulaInvalida;
            elseif ($NumError == 3003)
                $MensajeXFormatear = $ErrorNombreInvalido;
            elseif ($NumError != 0)
                $MensajeXFormatear = "No se manejó el error número " . $NumError . " en el proceso 'CambioUsuario'.";
        } // elseif (strcmp($Modo, $MODO_CAMBIO) == 0)
    } // else

    $MensajeXDesglosar = CFormateadorMensajes::FormatearMensajeError($MensajeXFormatear);
} // if ($NumError != 0)
elseif ($SeGuardoInformacionExitosamente)
    $MensajeXDesglosar = CFormateadorMensajes::FormatearMensajeOK("Se guardó el usuario exitosamente.");

$Usuario = htmlspecialchars($Usuario);
$Cedula = htmlspecialchars($Cedula);
$Nombre = htmlspecialchars($Nombre);

$HabilitarBorradoContrasena = "";
$BorradoContrasenaSeleccionado = "";

if (strcmp($Modo, $MODO_ALTA) == 0)
{
    $HabilitarBorradoContrasena = "disabled";
    $BitBorrarContrasena = 1;
} // if (strcmp($Modo, $MODO_ALTA) == 0)

$EsAdministradorSeleccionado = "";

if ($BitEsAdministrador)
    $EsAdministradorSeleccionado = "checked";

if ($BitBorrarContrasena)
    $BorradoContrasenaSeleccionado = "checked";

$MaximoTamanoCampoUsuario = CUsuarios::MAXIMO_TAMANO_CAMPO_USUARIO;
$MaximoTamanoCampoCedula = CUsuarios::MAXIMO_TAMANO_CAMPO_CEDULA;
$MaximoTamanoCampoNombre = CUsuarios::MAXIMO_TAMANO_CAMPO_NOMBRE;

?>
<!DOCTYPE html>
<html>
<?php
include "encabezados.php";
?>
<body>
<?php
$FormularioActivo = "Usuario"; // Este es un parámetro que recibe "menuApp.php"
include "menuApp.php";
?>
<form method="post">
    <div class="container mt-4">
        <div class="form-row justify-content-center">
            <div class="form-group col-8 col-md-6 col-lg-4">
                <label for="Usuario">Usuario</label>
                <input type="text" class="form-control" id="Usuario" name="Usuario" placeholder="Ingrese el usuario" value="<?php echo $Usuario; ?>" maxlength="<?php echo $MaximoTamanoCampoUsuario;?>">
            </div>
        </div>
        <div class="form-row justify-content-center">
            <div class="form-group col-8 col-md-6 col-lg-4">
                <label for="Cedula">Cédula</label>
                <input type="text" class="form-control" id="Cedula" name="Cedula" placeholder="Ingrese la cédula del usuario" value="<?php echo $Cedula; ?>" maxlength="<?php echo $MaximoTamanoCampoCedula;?>">
            </div>
        </div>
        <div class="form-row justify-content-center">
            <div class="form-group col-8 col-md-6 col-lg-4">
                <label for="Nombre">Nombre</label>
                <input type="text" class="form-control" id="Nombre" name="Nombre" placeholder="Ingrese el nombre del usuario" value="<?php echo $Nombre; ?>" maxlength="<?php echo $MaximoTamanoCampoNombre;?>">
            </div>
        </div>
        <div class="form-row justify-content-center">
            <div class="custom-control custom-checkbox col-8 col-md-6 col-lg-4">
                <input type="checkbox" class="custom-control-input" id="EsAdministrador" name="EsAdministrador" <?php echo $EsAdministradorSeleccionado; ?>>
                <label class="custom-control-label" for="EsAdministrador">Es Administrador</label>
           </div>
        </div>
<?php if (strcmp($Modo, $MODO_CAMBIO) == 0) { ?>
        <div class="form-row justify-content-center">
            <div class="custom-control custom-checkbox col-8 col-md-6 col-lg-4">
                <input type="checkbox" class="custom-control-input" id="BorrarContrasena" name="BorrarContrasena" <?php echo $HabilitarBorradoContrasena; ?> <?php echo $BorradoContrasenaSeleccionado; ?>>
                <label class="custom-control-label" for="BorrarContrasena">Borrar Contraseña</label>
           </div>
        </div>
<?php } // if (strcmp($Modo, $MODO_CAMBIO) == 0) ?>
        <div class="form-row justify-content-center mt-4">
            <div class="form-group col-8 col-md-6 col-lg-4">
                <button type="submit" class="btn btn-primary">Guardar</button>
                <button type="button" class="btn btn-primary" onclick="window.location.href='usuarios.php';">Regresar</button>
            </div>
        </div>
    </div>
<?php
if ($MensajeXDesglosar != "")
    echo $MensajeXDesglosar;
?>
</form>
</body>
</html>
