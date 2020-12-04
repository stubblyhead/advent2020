lines = File.readlines('./input', :chomp => true)

treecount = 0
width = lines[0].length
x = 0
y = 0

until y == lines.length - 1 do
  x += 3
  y += 1
  treecount += 1 if lines[y][x%width] == '#'
end

puts treecount

[[1,1],[5,1],[7,1],[1,2]].each do |i|
  x = 0
  y = 0
  thiscount = 0
  x_inc = i[0]
  y_inc = i[1]
  until y >= lines.length - 1 do
    x += x_inc
    y += y_inc
    thiscount += 1 if lines[y][x%width] == '#'
  end
  treecount *= thiscount
end

puts treecount
