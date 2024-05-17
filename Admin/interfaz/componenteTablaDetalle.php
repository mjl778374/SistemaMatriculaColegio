<div class="container mt-4">
<table class="table">
  <thead class="thead-dark">
    <tr>
    <?php
    for ($i = 0; $i < count($EncabezadoTabla); $i++)
        echo '<th scope="col">' . $EncabezadoTabla[$i] . '</th>';
?>
    </tr>
  </thead>
  <tbody>
    <?php
    for ($i = 0; $i < count($Filas); $i++)
    {
        echo "<tr>";
        $Fila = $Filas[$i];
        $ContinuarEnColumna = 0;
        $DesplazamientoAlineamientos = 0;

        if (count($Fila) >= 2 && $IncluirLinkPrimeraColumna)
        {
            echo '<th scope="row" align="' . $Alineamientos[0] . '"><a href="' . htmlspecialchars($Fila[0]) . '" target="' . $TargetLinks . '">' . htmlspecialchars($Fila[1]) . '</a></th>';
            $ContinuarEnColumna = 2;
            $DesplazamientoAlineamientos = -1;
      	} // if (count($Fila) >= 2 && $IncluirLinkPrimeraColumna)

        for ($j = $ContinuarEnColumna; $j < count($Fila); $j++)
            echo '<td align="' . $Alineamientos[$j+$DesplazamientoAlineamientos] . '">' . htmlspecialchars($Fila[$j]) . '</td>';

        echo "</tr>";
    } // for ($i = 0; $i < count($Filas); $i++)
?>
  </tbody>
</table>
</div>
