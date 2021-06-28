Brick = assert require 'src/Brick'

import random from math
import min from math
import floor from math

LevelMaker = {}

--  Global flags
NONE = 1
SINGLE_PY = 2
MULTI_PY = 3
-- row flags
SOLID = 1
ALTERNATE = 2
SKIP = 3
NONE = 4




LevelMaker.createMap = (self, level) ->
  bricks = {}
  numRows = random 1, 5
  numCols = random 7, 13

  numCols = numCols % 2 == 0 and (numCols + 1) or numCols

  heighestTier = min 3, floor(level / 5)
  heighestColor = min 5, floor(level % 5 + 3)

  for y = 1, numRows
    skip_p = random(1,2) == 1 and true or false
    alter_p = random(1,2) == 1 and true or false

    alter_color1 = random 1, heighestColor
    alter_color2 = random 1, heighestColor

    alter_tier1 = random 1, heighestTier
    alter_tier2 = random 1, heighestTier

    skip_f = random(2) == 1 and true or false
    alter_f = random(2) == 1 and true or false

    solid_color = random 1, heighestColor
    solid_tier = random 0, heighestColor

    for x = 1, numCols
      if skip_p and skip_f
        skip_f = not skip_f
        continue if true
      else
        skip_f = not skip_f

      b = Brick (x-1) * 32 + 8 + (13 - numCols) * 16, y * 16

      if alter_p and alter_f
        b.color = alter_color1
        b.tier = alter_tier1
        alter_f = not alter_f
      else
        b.color = alter_color2
        b.tier = alter_tier2
        alter_f = not alter_f

      if not alter_p
        b.color = solid_color
        b.tier = solid_tier

      table.insert bricks, b

  if #bricks == 0
    self.createMap level
  else
    bricks


LevelMaker
