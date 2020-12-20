lines = File.readlines('./input', :chomp => true)
time = lines[0].to_f #making this a float will make the calculations later more convenient
routes = lines[1].split(',').map { |i| i.to_i }

shortest_wait = 9999  #start with something suitably large
answer = 0
routes.each do |i|
  next if i == 0
  wait = ((time/i).ceil)*i - time
  if wait < shortest_wait
    shortest_wait = wait
    answer = (shortest_wait * i).to_i
  end
end

puts answer
