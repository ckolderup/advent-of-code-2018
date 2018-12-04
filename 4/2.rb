require_relative 'parse'

sleeping = parse('input.txt')

# [guard_id, minute, # times]
triplets = sleeping.map do |guard, minutes|
  freq = Hash[minutes.flatten.group_by(&:itself).map{ |k, v| [k, v.count] }]
  [guard] + freq.max_by { |k,v| v }
end

answer = triplets.max_by { |triplet| triplet.last }

puts "#{answer[0]} * #{answer[1]} = #{answer[0] * answer[1]}"
