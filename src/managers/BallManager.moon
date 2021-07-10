Ball = assert require 'src/Ball'


import insert from table
import remove from table
import random from math

class BallManager
  new: () =>
    @balls = {}
    @idx = 1
    @addBall Ball random 7


  update: (dt) =>
    for _, ball in ipairs @balls
      ball\update dt


  draw: =>
    for _, ball in ipairs @balls
      ball\draw!

  addBall: (x, y) =>
    ball = Ball random 7
    ball.dx = random -200, 200
    ball.dy = -140
    insert @balls, @idx, ball

  resetV: =>
    for _, ball in ipairs @balls
      ball.dx = random 100, 120
      ball.dy = random 100, -120

  removeBall: (i) =>
    remove @balls, i

  setAllPos: (x, y)=>
    for _, ball in ipairs @balls
      ball.x = x
      ball.y = y

  getBalls: =>
    @balls

