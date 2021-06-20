import max from math
import min from math

class Paddle
  new: (paddleType) =>
    @x = VIRTUAL_WIDTH / 2 - 32
    @y = VIRTUAL_HEIGHT - 32
    @dx = 0
    @width = 0
    @height = 16
    @skin = 1
    @size = 0
    @speed = 0
    @alterPaddle paddleType

  alterPaddle: (type) =>
    switch type
      when 'small'
        @size = 1
        @width = 32
        @speed = 300
      when 'medium'
        @size = 2
        @width = 64
        @speed = 200
      when 'big'
        @size = 3
        @width = 96
        @speed = 150
      when 'large'
        @size = 4
        @width = 128
        @speed = 100


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



