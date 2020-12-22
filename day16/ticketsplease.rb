require 'pry'
binding.pry

lines = File.readlines('./input', sep = "\n\n", :chomp => true)

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

def valid(rules, ticket)
  #returns 0 if ticket is valid, otherwise returns field that doesn't satisfy any rules
  valid_fields = {}
  ticket.each do |val|
    valid_fields[val] = []
    rules.each_key do |key|
      rules[key].each do |r|
        valid_fields[val].push(key) if r.cover?(val)
      end
    end
  end
  bad_vals = valid_fields.select { |k,v| v == [] }
  if bad_vals.keys == []
    return 0
  else
    return bad_vals.keys[0]
  end
end

bad_sum = 0
good_tickets = [my_ticket]
other_tickets.each do |i| 
  bad_rule = valid(rules, i)
  bad_rule == 0 ? good_tickets.push(i) : bad_sum += bad_rule
end

puts bad_sum
puts good_tickets.length