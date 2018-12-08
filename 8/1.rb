data = IO.readlines('input.txt').first.split(' ').map(&:to_i)

class Node
  attr_accessor :children
  attr_accessor :metadata

  def initialize
    @children = []
    @metadata = []
  end
end

def construct(data)
  node = Node.new

  child_count, metadata_count = data.shift(2)

  child_count.times do
    child, data = construct(data)
    node.children << child
  end

  node.metadata.concat(data.shift(metadata_count))

  [node, data]
end

def calculate(node)
  node.metadata.inject(0,&:+) +
  node.children.map { |child| calculate(child) }.flatten.inject(0,&:+)
end

root = construct(data).first

puts calculate(root)
