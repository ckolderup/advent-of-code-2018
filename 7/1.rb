
step_hash = {}

IO.readlines('input.txt').each do |line|
  x, y = /Step (.) must be finished before step (.)/.match(line).captures
  step_hash[y] ||= []
  step_hash[y] << x
end

# now fill in any missing gaps
step_hash.values.flatten.uniq.each do |label|
  step_hash[label] ||= []
end

steps = step_hash.to_a.sort_by(&:first)

answer = []

loop do
  now = steps.find { |x| x.last.empty? }
  steps.delete(now)
  steps.each do |step|
    step.last.delete(now.first)
  end
  answer << now.first
  break if steps.empty?
end

puts answer.join('')
