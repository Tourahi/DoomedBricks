
class Brick
  new: (x, y) =>
    @tier = 0
    @color = 1

    @x = x
    @y = y
    @width = 32
    @height = 16
    @inGame = true

  hit: =>
    Res.Sounds['brick-hit-2']\play!
    @inGame = false

  draw: =>
    if @inGame
      Graphics.draw Res.Textures['main'], Frames['bricks'][1 + ((@color - 1) * 4) + @tier],
        @x, @y
