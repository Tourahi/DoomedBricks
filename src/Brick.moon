import min from math
class Brick
  new: (x, y) =>
    @tier = 3
    @maxTiers = 3
    @color = 1
    @maxColors = 5
    @x = x
    @y = y
    @width = 32
    @height = 16

  setColor: (type) =>
    assert type > @maxColors, "Color does not exist"
    @color = type

  setTier: (type) =>
    assert type > @maxTiers, "Tier does not exist"
    @tier = type

  hit: =>
    Res.Sounds['brick-hit-2']\play!

  draw: =>
    -- print "Brick :", 1 + ((@color - 1) * 4) + @tier
    idx = min( 1 + ((@color - 1) * 4) + @tier, 21)
    Graphics.draw Res.Textures['main'], Frames['bricks'][idx],
      @x, @y
