passwords = File.readlines('./input', :chomp=>true)

validcount = 0

passwords.each do |pw|
  (policy, password) = pw.split(': ')
  letter = policy[-1]
  (min, max) = policy[0..-3].split('-')
  count = password.count(letter)
  validcount += 1 if count >= min.to_i && count <= max.to_i
end

puts validcount

validcount = 0

passwords.each do |pw|
  (policy, password) = pw.split(': ')
  letter = policy[-1]
  (first, second) = policy[0..-3].split('-').map{ |s| s.to_i }
  validcount += 1 if (password[first-1] == letter) ^ (password[second-1] == letter)
end

puts validcount
