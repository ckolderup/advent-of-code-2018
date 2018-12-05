units = IO.readlines('input.txt').map(&:strip).first.chars

def break_down(units)
  loop do
    match = units[0...-1].each_index.find do |index|
      units[index].downcase == units[index+1].downcase &&
      units[index] != units[index+1]
    end

    if match.nil?
      return units.size
    else
      units.slice!(match, 2)
    end
  end
end

answer = ('a'..'z').map do |candidate|
  cleaned = units.clone.delete_if { |c| c.downcase == candidate }
  [candidate, break_down(cleaned)]
end

# this is going to take 20 minutes or more :-/
puts "final tally":
answer.sort_by(&:last).each do |pair|
  puts "#{pair.first}: #{pair.last}"
end
