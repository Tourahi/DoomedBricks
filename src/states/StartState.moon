

highlighted = 1

export class StartState extends BaseState

  update: (dt) =>
    if Keyboard.wasPressed('up') or Keyboard.wasPressed('down')
      highlighted = highlighted == 1 and 2 or 1

    if Keyboard.wasPressed('escape')
      Event.quit!


