ids = File.readlines('input.txt')

twice = 0
thrice = 0
ids.each do |id|
  freq = id.split('')
            .group_by(&:itself)
            .values
            .map(&:size)
            .uniq

  twice += 1 if freq.include?(2)
  thrice += 1 if freq.include?(3)
end

puts "#{twice} * #{thrice} = #{twice * thrice}"
