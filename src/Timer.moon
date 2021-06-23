Ltimer = love.timer

class Timer
  new: (duration, onDone) =>
    @duration = duration
    @onDone = onDone
    @time = 0

  ticks: (frames) =>
    print frames * Ltimer.getFPS!
    frames * Ltimer.getFPS!

  tick: (owner, dt) =>
    @time += 1 * dt
    if @time >= @duration
      @onDone owner
      owner.timer = nil

