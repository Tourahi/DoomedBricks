Util = assert require 'src/Util'
Ball = assert require 'src/Ball'

import random from math

export class ServeState extends BaseState
  new: (P) =>
    @paddle = P.paddle
    @levelManager = P.levelManager
    @bricks = P.bricks or @levelManager\generate 1
    @health = P.health
    @score = P.score
    @level = P.level
    @ballsM = P.ballsM

  update: (dt) =>
    @paddle\update dt
    @ballsM\setAllPos @paddle.x + (@paddle.width / 2) - 4, @paddle.y - 8

    if (Keyboard.wasPressed('enter') or Keyboard.wasPressed('return'))
      GStateMachine\change 'play', {
        paddle: @paddle,
        bricks: @bricks,
        health: @health,
        score: @score,
        ballsM: @ballsM,
        levelManager: @levelManager
      }

    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    @paddle\draw!
    @ballsM\draw!

    for _, brick in pairs @bricks
      brick\draw!
    Util.DrawHealth @health
    Util.DrawScore @score
    Util.DrawLevel @level
    Graphics.printf "Press Enter to start.", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center'

