puts File.readlines('input.txt').map(&:to_i).reduce(:+)
