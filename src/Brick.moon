
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
    @inGame = true

  setColor: (type) =>
    assert type > @maxColors, "Color does not exist"
    @color = type

  setTier: (type) =>
    assert type > @maxTiers, "Tier does not exist"
    @tier = type

  hit: =>
    Res.Sounds['brick-hit-2']\play!
    @inGame = false

  draw: =>
    if @inGame
      Graphics.draw Res.Textures['main'], Frames['bricks'][1 + ((@color - 1) * 4) + @tier],
        @x, @y
