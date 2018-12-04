require_relative 'parse'

sleeping = parse('input.txt')

slept_amount = sleeping.map do |guard, minutes|
  { id: guard, amount: minutes.flatten.size }
end

max_sleeper = slept_amount.max_by { |record| record[:amount] }

freq = sleeping[max_sleeper[:id]].flatten.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
mode = sleeping[max_sleeper[:id]].flatten.max_by { |v| freq[v] }

puts "#{max_sleeper[:id]} * #{mode} = #{mode * max_sleeper[:id]}"


