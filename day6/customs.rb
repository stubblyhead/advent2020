answers = File.readlines('./input', sep = "\n\n", :chomp => true)

count = 0
answers.each do |i|
  thisgroup = i.gsub("\n",'') #i htink using gsub! here was fucking things up later
  count += thisgroup.split('').uniq.count
end

puts count

count = 0
answers.each do |i|
  groupsize = i.count("\n") + 1  #newlines + 1 is number of people in group
  yes_questions = i.gsub("\n",'').split('').uniq #get list of answers with at least one yes
  yes_questions.each do |a|
    count += 1 if i.count(a) == groupsize #increment count if the yes answer appears as many times as the group is large
  end
end

puts count
