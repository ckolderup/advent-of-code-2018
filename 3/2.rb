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
      fabric[curx] ||= Array.new
      fabric[curx][cury] ||= Array.new
      fabric[curx][cury] << id
    end
  end
end

candidate_inches = fabric.flatten(1).compact.select { |inch| inch.size == 1 }

# let's get weird ([id, # of solely-claimed inches] pairs)
results = candidate_inches.flatten
                          .group_by { |id| id }
                          .map { |id, count| [id, count.size]}

answer = results.find do |id, area|
  claims[id][:w] * claims[id][:h] == area
end

puts answer.first
