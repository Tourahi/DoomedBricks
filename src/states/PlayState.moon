Util = assert require 'src/Util'
Collisions = assert require 'src/Collisions'

import random from math

export class PlayState extends BaseState
  @level: 1
  new: (P) =>
    @paused = false
    @paddle = P.paddle
    @ballsM = P.ballsM
    @bricks = P.bricks
    @score = P.score
    @health = P.health
    @collisions = Collisions!
    @levelManager = P.levelManager

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
    @ballsM\update dt

    s,@bricks = @collisions\resolve_collisions @ballsM\getBalls!, @paddle, @bricks
    if #@bricks == 0
      @@level += 1
      @bricks = @levelManager\generate @@level
      GStateMachine\change 'serve',{
        paddle: @paddle,
        bricks: @bricks,
        health: @health,
        score: @score,
        ballsM: @ballsM
        levelManager: @levelManager,
        level: @@level
      }
    @score += s

    if @ballsM\getBalls![1].y >= VIRTUAL_HEIGHT and #@ballsM\getBalls! == 1
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
          ballsM: @ballsM
          levelManager: @levelManager,
          level: @@level
        }


    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    Util.DrawHealth @health
    Util.DrawScore @score
    Util.DrawLevel @@level
    @paddle\draw!
    @ballsM\draw!

    for _, brick in pairs @bricks
      brick\draw!

    if @paused
      Graphics.setFont Res.Fonts['large']
      Graphics.printf "PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center'


