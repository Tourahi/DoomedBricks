Util = assert require 'src/Util'
Ball = assert require 'src/Ball'

import random from math

export class ServeState extends BaseState
  new: (P) =>
    @paddle = P.paddle
    @bricks = P.bricks
    @health = P.health
    @score = P.score

    @ball = Ball!
    @ball.skin = random 7

  update: (dt) =>
    @paddle\update dt
    @ball.x = @paddle.x + (@paddle.width / 2) - 4
    @ball.y = @paddle.y - 8


    if Keyboard.wasPressed 'escape'
      Event.quit!



  draw: =>
    @paddle\draw!
    @ball\draw!

    for _, brick in pairs @bricks
      brick\draw!
    Util.DrawHealth @health
    Util.DrawScore @score
