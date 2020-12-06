passes = File.readlines('./input', :chomp=>true)

max_id = 0
passes.each do |i|
  row = i[0,7]
  seat = i[-3,3]
  row.gsub!('B','1')
  row.gsub!('F','0')
  seat.gsub!('R','1')
  seat.gsub!('L','0')
  seat_id = row.to_i(2) * 8 + seat.to_i(2)
  max_id = [max_id, seat_id].max
end

puts max_id
