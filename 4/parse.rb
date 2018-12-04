require 'date'

FORMAT = /\[(?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2})\] (?<action>.*)/

def parse(filename)

  log = IO.readlines(filename).map(&:strip)
  raw = log.map do |line|
    result = FORMAT.match(line)
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

  sleeping
end
