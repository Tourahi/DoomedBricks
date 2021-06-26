Util = assert require 'src/Util'
Collisions = assert require 'src/Collisions'

import random from math

export class PlayState extends BaseState
  new: (P) =>
    @paused = false
    @paddle = P.paddle
    @ball = P.ball
    @bricks = P.bricks
    @score = P.score
    @health = P.health
    @collisions = Collisions!

    @ball.dx = random -200, 200
    @ball.dy = random -50, -60


  update: (dt) =>
    if @paused
      if Keyboard.wasPressed 'space'
        @paused = false
        Res.Sounds['pause']\play!
      else
        return
    elseif Keyboard.wasPressed 'space'
      @paused = true
      Res.Sounds['pause']\play!
      return
    @paddle\update dt
    @ball\update dt

    @score += @collisions\resolve_collisions @ball, @paddle, @bricks


    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    Util.DrawHealth @health
    Util.DrawScore @score
    @paddle\draw!
    @ball\draw!

    for _, brick in pairs @bricks
      brick\draw!

    if @paused
      Graphics.setFont Res.Fonts['large']
      Graphics.printf "PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center'


