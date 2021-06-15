assert require 'src/Dependencies'


with love
  .load = (arg) ->
    Bino\watch "FPS",-> love.timer.getFPS!

  .update = () ->
    Bino\update!

  .draw = () ->
    Bino\draw!
