import random from math
import min from math
import abs from math

clamp = (n, low, high) -> math.min(math.max(n, low), high)


class Ball
  new: (skin) =>
    @width = 8
    @height = 8
    @dx = 0
    @dy = 0
    @mDx = {max: 200, min:-200}
    @mDy = {max: 200, min:-200}
    @skin = skin
    @x = VIRTUAL_WIDTH / 2 - 2
    @y = VIRTUAL_HEIGHT / 2 - 2
    @start!

  start: =>
    @dx = random -200, 200
    @dy = random -140, -200
    @x = VIRTUAL_WIDTH / 2 - 4
    @y = VIRTUAL_HEIGHT - 42
    --Bino\watch "D_x_y",-> {dx:@dx, dy:@dy}


  reset: =>
    @dx = 0
    @dy = 0
    @x = VIRTUAL_WIDTH / 2 - 2
    @y = VIRTUAL_HEIGHT / 2 - 2

  rebound: (shift) =>
    -- Dump self
    min_shift = min abs(shift.x), abs(shift.y)
    if abs(shift.x) == min_shift
      shift.y = 0
      @x += shift.x
      @dy *= 1.2
    else
      shift.x = 0
      @y += shift.y
      @dx *= 1.2

    if shift.x ~= 0
      @dx = -@dx
    if shift.y ~= 0
      @dy = -@dy


  update: (dt) =>
    @dx = clamp @dx, @mDx.min, @mDx.max
    @dy = clamp @dy, @mDy.min, @mDx.max
    @x += @dx * dt
    @y += @dy * dt


    if @x <= 0
      @x = 0
      @dx = -@dx
      Res.Sounds['wall-hit']\play!

    if @x > VIRTUAL_WIDTH - 8
      @x = VIRTUAL_WIDTH - @width
      @dx = -@dx
      Res.Sounds['wall-hit']\play!

    if @y <= 0
      @y = 0
      @dy = -@dy
      Res.Sounds['wall-hit']\play!

  draw: =>
    Graphics.draw Res.Textures['main'], Frames['balls'][@skin], @x, @y
