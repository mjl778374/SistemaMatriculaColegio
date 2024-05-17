<?php
include_once "CFormateadorMensajes.php";
$MensajeXDesglosar = "";

for($i = 0; $i < count($MensajesXDesglosar); $i++)
{
    $MensajeActual = $MensajesXDesglosar[$i];

    if ($MensajeActual[0] == $MENSAJE_OK)
    {
        $MensajeXFormatear = "";

        if ($MensajeActual[1] == $ID_MENSAJE_SE_VAN_INDEXAR_TODOS_USUARIOS)
            $MensajeXFormatear = "Se van a indexar los usuarios...";

        elseif ($MensajeActual[1] == $ID_MENSAJE_SE_INDEXARON_TODOS_USUARIOS)
            $MensajeXFormatear = "Se indexaron los usuarios exitosamente.";

        elseif ($MensajeActual[1] ==$ID_MENSAJE_SE_INDEXO_TODO_EXITOSAMENTE)
            $MensajeXFormatear = "Se indexó todo exitosamente.";

        if (strlen(trim($MensajeXFormatear) > 0))
            $MensajeXDesglosar = $MensajeXDesglosar . CFormateadorMensajes::FormatearMensajeOK($MensajeXFormatear);
    } // if ($MensajeActual[0] == $MENSAJE_OK)
    
    elseif ($MensajeActual[0] == $MENSAJE_ERROR)
        $MensajeXDesglosar = $MensajeXDesglosar . CFormateadorMensajes::FormatearMensajeError($MensajeActual[1]);
} // for($i = 0; $i < count($MensajesXDesglosar); $i++)

?>
<!DOCTYPE html>
<html>
<?php
    include "encabezados.php";
?>
<body>
<?php
    $FormularioActivo = "IndexarTodo"; // Este es un parámetro que recibe "menuApp.php"
    include "menuApp.php";
?>
<form method="post">
    <div class="container mt-4">
        <div class="form-row justify-content-center">
            <div class="form-group col-8 col-md-6 col-lg-4">
                <button type="submit" class="btn btn-primary btn-lg btn-block" name="IndexarTodo">Indexar Todo</button>
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
