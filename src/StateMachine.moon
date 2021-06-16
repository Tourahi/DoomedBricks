
empty = {
  draw: ->,
  update: ->,
  enter: ->,
  exit: ->
}

export class StateMachine
  new: (states) =>
    @empty = empty
    @states = states or {}
    @current = @empty

  change: (stateName, params) =>
    assert @states[stateName], "State does not exist."
    @current\exit!
    @current = @states[stateName]!
    @current\enter params

  update: (dt) =>
    @current\update dt

  draw: =>
    @current\draw!

