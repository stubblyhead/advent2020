passes = File.readlines('./input', :chomp=>true)

id_list = []
passes.each do |i|
  row = i[0,7]  #splitting these off wasn't necessary but oh well
  seat = i[-3,3]
  row.gsub!('B','1')
  row.gsub!('F','0')
  seat.gsub!('R','1')
  seat.gsub!('L','0')
  seat_id = row.to_i(2) * 8 + seat.to_i(2)
  id_list.push(seat_id)
end

puts id_list.max
id_list.sort
id_list.each_index do |i|
  if id_list[i+1] - id_list[i] == 2
    puts id_list[i] + 1
    exit
  end
end
