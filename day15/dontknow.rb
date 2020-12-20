sequence = [0,3,6] #initial sequence
seen = {} #hash to keep track of how long ago a number was last seen
sequence.each do |i|
  seen.keys.each { |j| seen[j] += 1 }
  seen[i] = 0
end

sequence.reverse! #i think it might be more convenient to prepend rather than append new numbers

(2020 - sequence.length).times do
  last_num = sequence[0]
  if seen[last_num]
    sequence.prepend(seen[last_num]) #add new number to sequence
  else
    sequence.prepend(0)
  end
  seen.keys.each { |i| seen[i] += 1 }
  seen[last_num] = 1

end
puts sequence[0]
