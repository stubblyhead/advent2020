lines = File.readlines('./input', :chomp => true)

treecount = 0
width = lines[0].length
x = 0
y = 0

until y = lines.length - 1 do
  x += 3
  y += 1
  treecount += 1 if lines[y][x%width] == '#'
end

puts treecount
