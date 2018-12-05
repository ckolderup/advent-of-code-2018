units = IO.readlines('input.txt').map(&:strip).first.chars

puts "starting size: #{units.size}"
loop do
  match = units[0...-1].each_index.find do |index|
    units[index].downcase == units[index+1].downcase &&
    units[index] != units[index+1]
  end

  if match.nil?
    puts "final size: #{units.size}"
    break
  else
    units.slice!(match, 2)
    #puts "down to: #{units.size}" if units.size % 100 == 0
  end
end
