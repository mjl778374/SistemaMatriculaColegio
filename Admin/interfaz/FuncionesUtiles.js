function ReemplazarTodo(sUnaHilera, sCaracteresXReemplazar, sCaracteresReemplazo)
{
    while (sUnaHilera.indexOf(sCaracteresXReemplazar) >= 0)
        sUnaHilera = sUnaHilera.replace(sCaracteresXReemplazar, sCaracteresReemplazo);

    return sUnaHilera;
} // function ReemplazarTodo(sUnaHilera, sCaracteresXReemplazar, sCaracteresReemplazo)

function AbrirURL(sURLCarpetaServidor, sURLRelativa)
{
    var m_sHref = sURLCarpetaServidor + "/" + sURLRelativa;
    AbrirURLAbsoluta(m_sHref);
} // function AbrirURL(sURLCarpetaServidor, sURLRelativa)

function AbrirURLAbsoluta(sURLAbsoluta)
{
    var m_sHref = sURLAbsoluta;
    window.open(m_sHref, '_blank');
} // function AbrirURLAbsoluta(sURLAbsoluta)
