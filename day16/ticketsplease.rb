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

def valid(rules, ticket)
  #returns 0 if ticket is valid, otherwise returns field that doesn't satisfy any rules
  valid_fields = Hash.new { |hash,key| hash[key] = [] }
  ticket.each do |val|
    rules.each_key do |key|
      rules[key].each do |r|
        valid_fields(val).push(key) if r.covers?(val)
      end
    end
  end
  bad_vals = valid_fields.select { |k,v| v == [] }
  bad_vals == [] ? return 0 : return[0]
end
