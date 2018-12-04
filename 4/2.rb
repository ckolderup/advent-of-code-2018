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

# [guard_id, minute, # times]
triplets = sleeping.map do |guard, minutes|
  freq = Hash[minutes.flatten.group_by(&:itself).map{ |k, v| [k, v.count] }]
  [guard] + freq.max_by { |k,v| v }
end

answer = triplets.max_by { |triplet| triplet.last }

puts "#{answer[0]} * #{answer[1]} = #{answer[0] * answer[1]}"
