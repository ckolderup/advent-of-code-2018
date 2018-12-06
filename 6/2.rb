# setup
points = IO.readlines('input.txt').map do |line|
  line.split(',').map(&:to_i)
end

bound_x = points.map(&:first).max + 2
bound_y = points.map(&:last).max + 2

# draw the map
map = Array.new(bound_y) { Array.new(bound_x) }
bound_y.times do |y|
  bound_x.times do |x|
    distances = points.each_index.map do |idx|
      (points[idx][0] - x).abs + (points[idx][1] - y).abs
    end
    map[y][x] = if distances.inject(&:+) < 10000
      '#'
    else
      nil
    end
  end
end

puts map.flatten.compact.size
