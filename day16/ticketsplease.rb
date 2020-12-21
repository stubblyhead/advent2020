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

puts rules
