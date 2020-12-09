class Node
  attr_reader :parents, :children, :child_counts, :name

  def initialize(name)
    @name = name
    @parents = []
    @children = []
    @child_counts = []
  end

  def add_parent(parent)
    @parents.push(parent)
  end

  def add_child(child, count)
    @children.push(child)
    @child_counts.push(count)
  end
end

# class Graph  #I think a hash will suffice for now
#   attr_accessor :vertices
#
#   def initialize()
#     @vertices = {}
#   end
# end

bags = File.readlines('./input', :chomp => true)
graph = {}
bags.each do |i|
  (outer, inner) = i.split(' bags contain ')
  graph[outer] = Node.new(outer) unless graph[outer]  #create a new node unless it already exists
  next if inner == 'no other bags.'
  contents = inner.split(/ bag[s]?[,|.]/ )
  contents.each do |i|
    (count, foo, color) = i.strip.partition(' ')
    graph[color] = Node.new(color) unless graph[color]
    graph[outer].add_child(color, count.to_i)
    graph[color].add_parent(outer)
  end
end

valid_bags = []
bag_count = 0

valid_bags += graph['shiny gold'].parents
while true  #I feel like I should only need to do this once but oh well
  valid_bags.each do |i|
    valid_bags += graph[i].parents
  end
  valid_bags.uniq.length == bag_count ? break : bag_count = valid_bags.uniq.length
end


puts bag_count
