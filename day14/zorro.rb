require 'pry'
binding.pry

lines = File.readlines('./testcase2', :chomp => true)

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

def calculate_addresses(mem_mask)
  x_loc = []
  addr_list = []
  mem_mask.split('').each_index { |i| x_loc.push(i) if mem_mask[i] == 'X' }
  (2**x_loc.length).times do |i|
    this_addr = mem_mask.clone
    x_loc.length.times do |j|
      i[j] == 1 ? this_addr[x_loc[j]] = '1' : this_addr[x_loc[j]] = '0'
    end
    addr_list.push(this_addr.to_i(2))
  end
  return addr_list
end

mask_bits = []
lines.each do |i|
  if i[0,4] == 'mask'
    mask = i.split(' ')[2]
    on_mask = mask.gsub('X','0').to_i(2)
    mask_bits = mask.split('')
  else
    parts = i.split(' ')
    addr = parts[0][4..].to_i
    addr = addr | on_mask
    addr = addr.to_s(2).rjust(mask.length, '0')
    val = parts[2].to_i
    mask_bits.each_index { |i| addr[i] = 'X' if mask_bits[i] == 'X' }
    # mask_bits.each_index do |i|
    #   case mask_bits[i]
    #   when 'X'
    #     addr[i] = 'X'
    #   when '1'
    #     addr[i] = (addr[i].to_i | 1).to_s
    #   when '0'
    #     addr[i] = (addr[i].to_i & 0).to_s
    #   end
    # end
    addr_list = calculate_addresses(addr)
    addr_list.each { |i| mem[i.to_i] = val }
  end
end

sum = 0
mem.each { |i| sum += i if i }
puts sum
