entries = File.readlines('./input', :chomp=>true).map{ |s| s.to_i }
entries.each do |i|
  target = 2020 - i
  entries.index(target) ? product = i*target : next
  puts product
  break
end

entries.each do |i|
  target = 2020 - i
  others = entries.clone
  others.delete(i) #want to be sure we don't try to use the same number twice
  others.each do |j|
    next if j > target
    subtarget = target - j
    others.index(subtarget) ? product = i * j * subtarget : next
    puts product
    exit
  end
end
