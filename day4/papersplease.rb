papers = File.readlines('./input', sep="\n\n", :chomp=>true)

validcount = 0

papers.each do |i|
  pp = i.split
  if pp.length == 8
    validcount += 1 #if all fields are present it's a valid passport
  elsif pp.length == 7
   pp.sort!
    validcount += 1 if i[1][0..2] == 'ecl' #only cid can be missing, so the second element has to start with 'ecl'
  end
end

puts validcount
