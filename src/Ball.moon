import random from math
import min from math
import abs from math
import timer from love

class Ball
  new: (skin) =>
    @width = 8
    @height = 8
    @dx = 0
    @dy = 0
    @skin = skin
    @x = VIRTUAL_WIDTH / 2 - 2
    @y = VIRTUAL_HEIGHT / 2 - 2
    @start!

  start: =>
    @dx = random -200, 200
    @dy = random -200, -200
    @x = VIRTUAL_WIDTH / 2 - 4
    @y = VIRTUAL_HEIGHT - 42

  -- AABB
  collides: (target) =>
    if @x > target.x + target.width or target.x > @x + @width
      return false

    if @y > target.y + target.height or target.y > @y + @height
      return false

    return true

  reset: =>
    @dx = 0
    @dy = 0
    @x = VIRTUAL_WIDTH / 2 - 2
    @y = VIRTUAL_HEIGHT / 2 - 2

  rebound: (shift) =>
    min_shift = min abs(shift.x), abs(shift.y)
    if abs(shift.x) == min_shift
      shift.y = 0
      @x += shift.x * 1.02
    else
      shift.x = 0
      @y += shift.y * 1.02

    if shift.x ~= 0
      @dx = -(@dx + (@dx * timer.getDelta!))
    if shift.y ~= 0
      @dy = -(@dy + (@dy * timer.getDelta!))

  update: (dt) =>
    print "dx : ", @dx
    print "dy : ", @dy
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
