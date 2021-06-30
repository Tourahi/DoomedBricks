
export class GameOverState extends BaseState
  new: (P) =>
    @score = P.score
    @loveframes = P.loveframes

  update: (dt) =>
    if (Keyboard.wasPressed('enter') or Keyboard.wasPressed('return'))
      GStateMachine\change 'start', {
        loveframes: @loveframes
      }
    if Keyboard.wasPressed 'escape'
      Event.quit!

  draw: =>
    Graphics.setFont Res.Fonts['large']
    Graphics.printf "Game Over.", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center'
    Graphics.setFont Res.Fonts['medium']
    Graphics.printf "Your Score:" .. tostring(@score), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center'
    Graphics.printf "Press Enter to Restart.", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center'
