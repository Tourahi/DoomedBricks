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
    @levelManager = P.levelManager

    @ball.dx = random 50, 70
    @ball.dy = random -50, -200


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

    s,@bricks = @collisions\resolve_collisions @ball, @paddle, @bricks
    @score += s
    if @ball.y >= VIRTUAL_HEIGHT
      @health -= 1
      Res.Sounds['hurt']\play!

      if @health == 0
        GStateMachine\change 'game-over', {
          score: @score
        }
      else
        GStateMachine\change 'serve',{
          paddle: @paddle,
          bricks: @bricks,
          health: @health,
          score: @score,
          ball: @ball
          levelManager: @levelManager
        }


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


