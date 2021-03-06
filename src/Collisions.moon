Paddle = assert require 'src/Paddle'
Ball  = assert require 'src/Ball'
Timer = assert require "src/Timer"
Score = assert require "src/Score"

import abs from math
import remove from table

class Collisions
  new: =>
    @score = 0

  overlap_along_axis: (aPos, bPos, aSize, bSize) =>
    diff = bPos - aPos
    dist = abs diff
    overlap = ( aSize + bSize ) / 2 - dist
    overlap, diff / (dist * overlap)

  check_rectangles_overlap: (a, b) =>
    overlap = false
    shift_b_x, shift_b_y = 0, 0

    if a.x < b.x + b.width and
      b.x < a.x + a.width and
      a.y < b.y + b.height and
      b.y < a.y + a.height
        overlap = true
        if ( a.x + (a.width / 2) ) < ( b.x + (b.width / 2) )
           shift_b_x = ( a.x + a.width ) - b.x
        else
           shift_b_x = a.x - ( b.x + b.width )

        if ( a.y + (a.height / 2) ) < ( b.y + (b.height / 2) )
           shift_b_y = ( a.y + a.height ) - b.y
        else
           shift_b_y = a.y - ( b.y + b.height )
        if a.__class == Paddle and b.__class == Ball
          if  b.x  <  a.x + (a.width / 2) and a.dx < 0
            b.dx -= 70 + (8 * (a.x + a.width / 2 - b.x))
          if  b.x  >  a.x + (a.width / 2) and a.dx > 0
            b.dx += 70 + (8 * abs((a.x + a.width / 2 - b.x)))
    Bino\watch "ballDXY",-> {"dx":b.dx, "dy:":b.dy}

    return overlap, shift_b_x, shift_b_y

  ball_paddle_collision: (paddle, ball) =>
    overlap, shift_b_x, shift_b_y = @check_rectangles_overlap paddle, ball
    if overlap
      -- rebound
      paddle.freez = true
      paddle.timer = Timer 0.028,(owner) => owner.freez = false
      ball\rebound( {x: shift_b_x, y:shift_b_y} )


  ball_bricks_collision: (ball, bricks) =>
    for i, brick in pairs bricks
      overlap, shift_b_x, shift_b_y = @check_rectangles_overlap brick, ball
      if overlap
        Res.Sounds['brick-hit-2']\stop!
        Res.Sounds['brick-hit-2']\play!
        @score = Score.genScore brick
        ball\rebound( {x: shift_b_x, y:shift_b_y} )
        remove bricks, i, brick
    bricks




  resolve_collisions: (balls, paddle, bricks) =>
    @score = 0
    for _, ball in ipairs balls
      @ball_paddle_collision paddle, ball
    for _, ball in ipairs balls
      bricks = @ball_bricks_collision ball, bricks
    @score, bricks




