adapters = File.readlines('./input', :chomp => true).map { |i| i.to_i }

adapters.push(0)  #add ratings for outlet and device (next line)
adapters.push(adapters.max+3)

adapters.sort!  #waiting for the other shoe to drop on this one honestly

diff_one = 0
diff_three = 0

adapters.each_index do |i|
  break if i == adapters.length - 1
  diff_one += 1 if adapters[i+1] - adapters[i] == 1
  diff_three += 1 if adapters[i+1] - adapters[i] == 3
  puts "uhoh" if adapters[i+1] - adapters[i] > 3
end

puts diff_one * diff_three
