require 'set'

changes = File.readlines('input.txt').map(&:to_i)

freq = 0; found = Set.new([0])

changes.cycle.each do |change|
  break if found.add?(freq += change).nil?
end

puts freq
