Brick = assert require 'src/Brick'

import random from math
import min from math
import floor from math


class LevelManager
  @MaxTiers: 3
  @MaxColors: 5
  @numGenerators: 1
  new: =>
    -- Heighest tier possible
    -- needs update before a new map creation
    @heighestTier = 0
    -- Heighest color possible
    -- needs update before a new map creation
    @heighestColor = 0
    @numRows = 0
    @numCols = 0
    @maxRows = 5
    @maxCols = 13

  newHTierHColor: (level) =>
    @heighestTier = min @@MaxTiers, floor(level / 5)
    @heighestColor = min @@MaxColors, floor(level % 5 + 3)


  newNumColRow: =>
    @numRows = random 1, @maxRows
    @numCols = random 7, @maxCols



  generatorA: (level) =>
    @newHTierHColor level
    @newNumColRow!
    bricks = {}
    i = 1
    for y = 1, @numRows
      -- if skipping pattern is allowed
      skip_p = random(1,2) == 1 and true or false
      -- if altering pattern is allowed
      alter_p = random(1,2) == 1 and true or false

      alter_color1 = random 1, @heighestColor
      alter_color2 = random 1, @heighestColor

      alter_tier1 = random 0, @heighestTier
      alter_tier2 = random 0, @heighestTier
      -- flags
      skip_f = random(2) == 1 and true or false
      alter_f = random(2) == 1 and true or false

      solid_color = random 1, @heighestColor
      solid_tier = random 0, @heighestColor
      for x = 1, @numCols
        if skip_p and skip_f
          skip_f = not skip_f
          continue if true
        else
          skip_f = not skip_f

        b = Brick (x-1) * 32 + 8 + (13 - @numCols) * 16, y * 16

        if alter_p and alter_f
          b.color = alter_color1
          b.tier = alter_tier1
          alter_f = not alter_f
        else
          b.color = alter_color2
          b.tier = alter_tier2
          alter_f = not alter_f

        if alter_p == false
          b.color = solid_color
          b.tier = solid_tier

        table.insert bricks, i, b
        i += 1

    if #bricks == 0
      @generatorA level
    else
      bricks

  generate: (level) =>
    gn = random 1, @@numGenerators
    bricks = {}
    switch gn
      when 1
        bricks = @generatorA level
        -- Dump bricks

    return bricks





