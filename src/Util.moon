



GenerateQuads = (atlas, tileW, tileH) ->
  sheetW = atlas\getWidth! / tileW
  sheetH = atlas\getHeight! / tileH

  sheetCount = 1
  spritesheet = {}

  for y = 0, sheetH - 1
    for x = 0, sheetW - 1
      spritesheet[sheetCount] = Graphics.newQuad x * tileW, y * tileH, tileW,
        tileH, atlas\getDimensions!
      sheetCount += 1

  spritesheet


table.slice = (t, f, l, s) ->
  sliced = {}

  for i = f or 1, l or #t, s or 1
    sliced[#sliced+1] = t[i]

  sliced



GenerateQuadsPaddles = (atlas) ->
  x = 0
  y = 64

  counter = 1
  quads = {}

  for i = 0, 3
    -- smallest
    quads[counter] = Graphics.newQuad x, y, 32, 16, atlas\getDimensions!
    counter += 1

    -- medium
    quads[counter] = Graphics.newQuad x + 32, y, 64, 16, atlas\getDimensions!
    counter += 1

    -- large
    quads[counter] = Graphics.newQuad x + 96, y, 96, 16, atlas\getDimensions!
    counter += 1

    -- huge
    quads[counter] = Graphics.newQuad x, y + 16, 126, 16, atlas\getDimensions!
    counter += 1

    x = 0
    y += 32

  quads

GenerateQuadsBalls = (atlas) ->
  x = 96
  y = 48

  counter = 1
  quads = {}

  for i = 0, 3
    quads[counter] = Graphics.newQuad x, y, 8, 8, atlas\getDimensions!
    x += 8
    counter += 1

  x = 96
  y = 56

  for i = 0, 2
    quads[counter] = Graphics.newQuad x, y, 8, 8, atlas\getDimensions!
    x += 8
    counter += 1

  quads

GenerateQuadsBricks = (atlas) ->
  return table.slice GenerateQuads(atlas, 32, 16), 1, 21

{:GenerateQuads, :GenerateQuadsPaddles, :GenerateQuadsBalls, :GenerateQuadsBricks}
