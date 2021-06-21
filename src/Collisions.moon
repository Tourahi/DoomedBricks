Paddle = assert require 'src/Paddle'
Ball  = assert require 'src/Ball'
import abs from math

class Collisions
  new: =>

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
            b.dx = -50 + -(8 * (a.x + a.width / 2 - b.x))
          if  b.x  >  a.x + (a.width / 2) and a.dx > 0
            b.dx = 50 + (8 * abs((a.x + a.width / 2 - b.x)))

    return overlap, shift_b_x, shift_b_y

  ball_paddle_collision: (paddle, ball) =>
    overlap, shift_b_x, shift_b_y = @check_rectangles_overlap paddle, ball
    if overlap
      -- rebound
      ball\rebound( {x: shift_b_x, y:shift_b_y} )


  ball_bricks_collision: (ball, bricks) =>
    for _, brick in pairs bricks
      overlap, shift_b_x, shift_b_y = @check_rectangles_overlap brick, ball
      if brick.inGame and overlap
        ball\rebound( {x: shift_b_x, y:shift_b_y} )
        brick\hit!


  resolve_collisions: (ball, paddle, bricks) =>
    @ball_paddle_collision paddle, ball
    @ball_bricks_collision ball, bricks




