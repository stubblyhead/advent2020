numbers = File.readlines('./input', :chomp => true).map { |i| i.to_i }

target = nil
weak = nil
numbers.each_index do |i|
  next if i < 25  #i could do this more elegantly

  searchspace = numbers[i-25,25]  #get the previous x numbers to search
  searchspace.each_index do |j|
    next if searchspace[j] * 2 == numbers[i]  #the two numbers have to be different, so go to the next if it's exactly half
    target = numbers[i] - searchspace[j]
    break if searchspace.index(target)  #if the search space has the conpmlement then we can move on
    if j == searchspace.length - 1
      puts weak = numbers[i] #we should only hit this line if the number isn't the sum of any 2 of the previous 5
      break
    end
  end
end

numbers.each_index do |i|
  numbers.length.times do |j|
    next if j <= i
    sum = numbers[i..j].sum
    if sum == weak
      puts numbers[i..j].min + numbers[i..j].max
      exit
    elsif sum > weak
      break
    end
  end
end
