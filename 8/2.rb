data = IO.readlines('input.txt').first.split(' ').map(&:to_i)

class Node
  attr_accessor :children
  attr_accessor :metadata

  def initialize
    @children = []
    @metadata = []
  end

  def value
    if @children.empty?
      @metadata.inject(0,&:+)
    else
      @metadata.map do |index|
        next if index.zero?

        if child = children[index - 1]
          child.value
        else
          0
        end
      end.compact.inject(0,&:+)
    end
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


root = construct(data).first

puts root.value
