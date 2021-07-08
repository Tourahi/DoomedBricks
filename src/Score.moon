
genScore = (brick) ->
  score = 0
  switch brick.color
    when 1
      score = 5 + (brick.tier * 10)
    when 2
      score = 10 + (brick.tier * 10)
    when 3
      score = 20 + (brick.tier * 10)
    when 4
      score = 35 + (brick.tier * 10)
    when 5
      score = 50 + (brick.tier * 10)
  score


{:genScore}
