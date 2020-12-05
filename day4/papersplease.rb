papers = File.readlines('./input', sep="\n\n", :chomp=>true)

validcount = 0
validate = []
papers.each do |i|
  pp = i.split
  if pp.length == 8 #if all fields are present it might be a valid passport
    validate += [pp.sort] #collect passports with correct fields for further validation
  elsif pp.length == 7
   pp.sort!
   if pp[0][0..2] == 'byr' && pp[1][0..2] == 'ecl'
     #only cid can be missing, so the first element has to start with 'byr,
     #and the second element has to start with 'ecl'
     validate += [pp]
   end
  end
end

puts validate.length
eyecolors = %w(amb blu brn gry grn hzl oth)
validate.each do |i|
  i.delete_at(1) if i.length == 8 #cid is irrelevant, so we don't need to do any validation
  byr = i[0][4..].to_i
  next if byr < 1920 or byr > 2002 #invalid if byr is outside this range
  ecl = i[1][4..]
  next unless eyecolors.index(ecl) #invalid if ecl not found in this array
  eyr = i[2][4..].to_i
  next if eyr < 2020 or eyr > 2030 #invalid if eyr outside this range
  hcl = i[3][4..]
  next unless hcl.match(/^\#[0-9a-f]{6}$/) #invalid unless this pattern matches
  hgt = i[4][4..]
  if hgt[-2,2] == 'cm'
    hgt = hgt.to_i
    next if hgt < 150 or hgt > 193 #valid height range in cm
  elsif hgt[-2,2] == 'in'
    hgt = hgt.to_i
    next if hgt < 59 or hgt > 76 #valid height range in in
  else
    next #should only get here if there's no units which means its invalid
  end
  iyr = i[5][4..].to_i
  next if iyr < 2010 or iyr > 2020
    pid = i[6][4..]
  next unless pid.match(/^\d{9}$/) #only valid if pid is exactly 9 digits
  validcount += 1 #only valid passports should reach this point
end

puts validcount
