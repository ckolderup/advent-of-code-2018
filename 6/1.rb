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
      [idx, (points[idx][0] - x).abs + (points[idx][1] - y).abs]
    end
    min = distances.min_by { |pair| pair.last }
    map[y][x] = if distances.count { |pair| pair.last == min.last} > 1
      nil
    else
      min.first
    end
  end
end

# find and eliminate infinite areas
# first stab: delete anything that has a value on the outside edges
crimes = []
bound_x.times.each do |x|
  crimes << map[x][0]
  crimes << map[x][bound_y-1]
end
bound_y.times.each do |y|
  crimes << map[0][y]
  crimes << map[bound_x-1][y]
end

map = map.flatten.compact
crimes.compact.each do |crime|
  map.delete(crime)
end

# of the remaining map, count the most common
puts map.inject(Hash.new(0)){ |p, v| p[v]+=1; p}.values.max
