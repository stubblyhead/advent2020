answers = File.readlines('./input', sep = "\n\n", :chomp => true)

count = 0
answers.each do |i|
  i.gsub!("\n",'')
  count += i.split('').uniq.count
end

puts count
