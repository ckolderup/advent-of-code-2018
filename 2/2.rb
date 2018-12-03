require_relative 'distance'

ids = File.readlines('input.txt').map(&:strip)

dist = ids.combination(2).find do |a, b|
  levenshtein_distance(a, b) == 1
end

puts "1. #{dist.first}"
puts "2. #{dist.last}"

# technically I should automate the actual answer
# but it's easy to spot by eyeballing it at this point
