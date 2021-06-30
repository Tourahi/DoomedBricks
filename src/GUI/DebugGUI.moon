createToolbare =  ->
  frame = loveframes.Create "frame"
  frame\SetName "Toolbar"
  frame\SetSize 400, 85
  frame\CenterWithinArea unpack(centerarea)

  panel = loveframes.Create "panel", frame
  panel\SetPos 5, 30
  panel\SetSize 385, 50


{:createToolbare}
