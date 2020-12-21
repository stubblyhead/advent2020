lines = File.readlines('./testcase', sep = "\n\n", :chomp => true)

rules = {}

my_ticket = []
other_tickets = []

lines[0].each_line do |i|
  i.chomp!
  name,ranges = i.split(':')
  rules[name] = []
  ranges = ranges.split('or').map { |i| i.strip }
  ranges.each do |r|
    min,max = r.split('-').map { |i| i.to_i }
    rules[name].push(min..max)
  end
end

my_ticket = lines[1].split("\n")[1].split(',').map { |i| i.to_i }
other_tickets = lines[2].split("\n")[1..].map{|i| i.split(',').map { |j| j.to_i } }

p my_ticket
p other_tickets
