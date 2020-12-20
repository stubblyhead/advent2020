require 'pry'
binding.pry

lines = File.readlines('./input ', :chomp => true)

mask = ''
mem = []
on_mask = nil
off_mask = ''

lines.each do |i|
  if i[0,4] == 'mask'
    mask = i.split(' ')[2]
    on_mask = mask.gsub('X','0').to_i(2)  #do a bitwise OR to turn bits on
    off_mask = ''
    mask.each_char { |c| c == '0'? off_mask += '1' : off_mask += '0' }
    off_mask = ~(off_mask.to_i(2)) #do a bitwise AND to turn bits off
  else
    parts = i.split(' ')
    addr = parts[0][4..].to_i
    val = parts[2].to_i
    mem[addr] = val | on_mask
    mem[addr] = mem[addr] & off_mask
  end
end

sum = 0
mem.each { |i| sum += i if i}
puts sum

def build_masks(mem_mask)
  x_loc = []
  mask_list = []
  mem_mask.split('').each_index { |i| x_loc.push(i) if mem_mask[i] == 'X' }
  (2**x_loc.length).times do |i|
    this_mask = mem_mask.clone
    x_loc.length.times do |j|
      i[j] == 1 ? this_mask[x_loc[j]] = '1' : this_mask[x_loc[j]] = '0'
    end
    mask_list.push(this_mask.to_i(2))
  end
  return mask_list
end
