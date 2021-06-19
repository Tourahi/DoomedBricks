import max from math
import min from math

class Paddle
  new: =>
    @x = VIRTUAL_WIDTH / 2 - 32
    @y = VIRTUAL_HEIGHT - 32
    @dx = 0
    @width = 64
    @height = 16
    @skin = 1
    @size = 2
    @speed = 200

  update: (dt) =>
    if Keyboard.isDown 'left'
      @dx = -@speed
    elseif Keyboard.isDown 'right'
      @dx = @speed
    else
      @dx = 0

    if @dx < 0
      @x = max 0, @x + @dx * dt
    else
      @x = min VIRTUAL_WIDTH - @width, @x + @dx * dt

  draw: =>
    Graphics.draw Res.Textures['main'], Frames['paddles'][@size + (4 * (@skin - 1))],
      @x, @y



