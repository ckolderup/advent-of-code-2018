def play(num_players, up_to)
  scores = Array.new(num_players, 0)
  circle = [0]
  previous = 0

  (1..up_to).each do |marble|

    if (marble % 23 == 0)
      player = marble % num_players
      now = (previous - 7) % circle.size
      scores[player] ||= 0
      scores[player] += marble + circle.delete_at(now)
      previous = now
    else
      now = (previous + 2) % circle.size
      circle.insert(now, marble)
      previous = now
    end
  end

  scores.max
end

examples = File.readlines('examples.txt').map do |x|
  x.chomp.split(';').map(&:to_i)
end

input = File.readlines('input.txt').map do |x|
  x.chomp.split(';').map(&:to_i)
end

examples.each do |game|
  high_score = play(game[0], game[1])
  puts "#{game[2] == high_score ? 'PASS' : 'FAIL'}: " +
       "expected #{game[2]}, got #{high_score}"
end

input.each do |game|
  high_score = play(game[0], game[1])
  puts "high score: #{high_score}"
end
