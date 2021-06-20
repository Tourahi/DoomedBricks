Brick = assert require 'src/Brick'

import random from math

LevelMaker = {}



LevelMaker.createMap = (level) ->
  bricks = {}
  numRows = random 1, 5
  numCols = random 7, 13

  for y = 1, numRows
    for x = 1, numCols
      b = Brick (x-1) * 32 + 8 + (13 - numCols) * 16, y * 16
      table.insert bricks, b

  bricks


LevelMaker
