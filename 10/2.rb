  FORMAT = /position=<\s*(?<x>-?\d+),\s*(?<y>-?\d+)> velocity=<\s*(?<vx>-?\d+),\s*(?<vy>-?\d+)>/

class Point
  def initialize(x, y, vx, vy)
    @x = x
    @y = y
    @vx = vx
    @vy = vy
  end

  def pos_at(t)
    [@x + (t * @vx), @y + (t * @vy)]
  end
end

def grid_at(points, t)
  points_at = points.map { |p| p.pos_at(t) }
  minx = points_at.map(&:first).min
  miny = points_at.map(&:last).min

  if minx != 0
    points_at.each { |p| p[0] -= minx }
  end

  if miny != 0
    points_at.each { |p| p[1] -= miny }
  end

  maxx = points_at.map(&:first).max + 1
  maxy = points_at.map(&:last).max + 1

  if maxy < 12
    # this is a candidate, actually construct it
    puts "found! constructing..."
    grid = Array.new(maxy, [])
    maxy.times.each do |y|
      grid[y] = Array.new(maxx, '.')
    end

    puts "width: #{maxx}"
    points_at.each_with_index do |point, idx|
      grid[point.last][point.first] = 'x'
      puts "#{idx}/#{points_at.size}"
    end

    grid
  else
    []
  end
end

def draw_grid(grid)
  grid.each do |line|
    puts line.join('')
  end
end

input = File.readlines('input.txt').map(&:strip).map do |line|
  result = FORMAT.match(line)
  Point.new(result[:x].to_i,
            result[:y].to_i,
            result[:vx].to_i,
            result[:vy].to_i)
end

puts "loaded! running..."

i = 0
loop do
  result = grid_at(input, i)
  if result.size > 0
    draw_grid(result)
    puts i
    break
  end
  i += 1
end
