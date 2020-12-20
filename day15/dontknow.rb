sequence = [0,3,6] #initial sequence
seen = Hash.new { |hash,key| hash[key] = [] } #hash to keep track of most recent instance of a number
sequence.each_index do |i|
  seen[sequence[i]] = [i+1]
end
last_num = sequence[-1]
#seen[last_num] = []
#sequence.reverse! #i think it might be more convenient to prepend rather than append new numbers

#(2020 - sequence.length).times do
(30000000 - sequence.length).times do |i|
  #puts last_num
  if seen[last_num].length == 1 #only saw this number once so far
    #seen[last_num] = [i+3]
    seen[0].push(i+4)
    last_num = 0
  else
    last_num = seen[last_num][-1] - seen[last_num][-2]
    seen[last_num].push(i+4)

  end
  #
  # if seen[last_num]
  #   sequence.prepend(seen[last_num]) #add new number to sequence
  # else
  #   sequence.prepend(0)
  # end
  # seen.keys.each { |i| seen[i] += 1 }
  # seen[last_num] = 1

end
puts last_num
