require 'date'

format = /\[(?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2})\] (?<action>.*)/

log = IO.readlines('input.txt').map(&:strip)

raw = log.map do |line|
  result = format.match(line)
  {
    time: DateTime.parse(result[:date]),
    action: result[:action]
  }
end

# sort by time
raw.sort_by! { |record| record[:time] }

# reduce to guard + array of minutes asleep ranges
cur_guard = -1
sleeping = {}
raw.each do |record|
  if found = /Guard \#(?<id>\d+) begins shift/.match(record[:action])
    cur_guard = found[:id].to_i
  elsif record[:action] == 'falls asleep'
    sleeping[cur_guard] ||= []
    sleeping[cur_guard] << [record[:time].minute]
  elsif record[:action] == 'wakes up'
    start = sleeping[cur_guard].last.last + 1
    finish = record[:time].minute - 1
    sleeping[cur_guard].last.concat(((start)..finish).to_a)
  else
    exit('oh no')
  end
end

slept_amount = sleeping.map do |guard, minutes|
  { id: guard, amount: minutes.flatten.size }
end

max_sleeper = slept_amount.max_by { |record| record[:amount] }

freq = sleeping[max_sleeper[:id]].flatten.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
mode = sleeping[max_sleeper[:id]].flatten.max_by { |v| freq[v] }

puts "#{max_sleeper[:id]} * #{mode} = #{mode * max_sleeper[:id]}"


