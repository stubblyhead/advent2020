papers = File.readlines('./input', sep="\n\n", :chomp=>true)

validcount = 0

papers.each do |i|
  pp = i.split
  if pp.length == 8
    puts "#{pp} is valid, all fields present"
    validcount += 1 #if all fields are present it's a valid passport
  elsif pp.length == 7
   pp.sort!
   if pp[1][0..2] == 'ecl'  #only cid can be missing, so the second element has to start with 'ecl'
     validcount += 1
     puts "#{pp} is valid, only cid is missing"
   end
  end
end

puts validcount
