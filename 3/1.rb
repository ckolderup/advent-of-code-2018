format = /\#(?<id>\d+) \@ (?<x>\d+)\,(?<y>\d+)\: (?<w>\d+)x(?<h>\d+)/

claims = {}
fabric = Array.new

File.readlines('input.txt').each do |line|
  result = format.match(line.strip)
  claims[result[:id].to_i] = {
    x: result[:x].to_i,
    y: result[:y].to_i,
    w: result[:w].to_i,
    h: result[:h].to_i
  }
end

claims.each do |id, claim|
  claim[:w].times do |widx|
    claim[:h].times do |hidx|
      curx = claim[:x] + widx
      cury = claim[:y] + hidx
      fabric[curx] ||= Array.new(0)
      fabric[curx][cury] = fabric[curx][cury].to_i + 1
    end
  end
end

puts fabric.flatten.select { |x| x.to_i > 1 }.size
