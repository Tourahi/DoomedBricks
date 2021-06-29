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
    ball.dx = random 50, 70
    ball.dy = random -50, -200
    insert @balls, @idx, ball


  removeBall: (i) =>
    remove @balls, i

  setAllPos: (x, y)=>
    for _, ball in ipairs @balls
      ball.x = x
      ball.y = y

  getBalls: =>
    @balls

