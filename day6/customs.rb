answers = File.readlines('./input', sep = "\n\n", :chomp => true)
answers[-1].chomp! #not sure why this isn't getting chomped already, but it's not

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
    if i.count(a) == groupsize #increment count if the yes answer appears as many times as the group is large
      all_yes += a
      count += 1
    end
  end
end

puts count
