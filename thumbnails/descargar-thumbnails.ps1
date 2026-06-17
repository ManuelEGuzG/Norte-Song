$canciones = @(
  @{id="N_obYr-RPJA"; nombre="bendito-jesus"},
  @{id="w66bfbeKny0"; nombre="fiel"},
  @{id="YNou3YGzP_M"; nombre="tu-mirada"},
  @{id="pORjEfnPALk"; nombre="desde-mi-interior"},
  @{id="rbHIRvfNxBA"; nombre="oceanos"},
  @{id="0pOVNIsyIXM"; nombre="gracia-sublime"},
  @{id="xJ_ZZkM5fGY"; nombre="creo-en-ti"},
  @{id="-fz292HNU_w"; nombre="tu-amor"},
  @{id="yhSQZHZZy08"; nombre="cuan-grande"},
  @{id="sAm49exVyZc"; nombre="abre-mis-ojos"},
  @{id="kIsrX9_ld64"; nombre="cante-al-senor"},
  @{id="vQiBdYP1TmI"; nombre="admirable"},
  @{id="naG_gVo8buc"; nombre="alaba"},
  @{id="SnIzImY9wO4"; nombre="bondad-de-dios"},
  @{id="IdAVbVAgDgE"; nombre="mi-confianza"},
  @{id="QmuHMNGMTVw"; nombre="en-la-cruz"}
)

foreach ($c in $canciones) {
  $url = "https://i3.ytimg.com/vi/$($c.id)/mqdefault.jpg"
  $out = "public\thumbnails\$($c.id).jpg"
  Invoke-WebRequest -Uri $url -OutFile $out
  Write-Host "✓ $($c.nombre)"
}