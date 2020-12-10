numbers = File.readlines('./testcase', :chomp => true).map { |i| i.to_i }

target = nil
numbers.each_index do |i|
  next if i < 5  #i could do this more elegantly

  searchspace = numbers[i-5,5]  #get the previous x numbers to search
  searchspace.each_index do |j|
    next if searchspace[j] * 2 == numbers[i]  #the two numbers have to be different, so go to the next if it's exactly half
    target = numbers[i] - searchspace[j]
    break if searchspace.index(target)  #if the search space has the conpmlement then we can move on
    if j == searchspace.length - 1
      puts numbers[i] #we should only hit this line if the number isn't the sum of any 2 of the previous 5
      exit
    end
  end
end
