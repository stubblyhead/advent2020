class Gameboy
  attr_reader :pointer, :accumulator, :prev_accumulator

  def initialize(instructions)
    @instructions = instructions
    @pointer = 0
    @accumulator = 0
    @prev_accumulator = 0
  end

  def acc(arg)
    @prev_accumulator = @accumulator
    @accumulator += arg
    @pointer += 1
  end

  def jmp(arg)
    @pointer += arg
  end

  def nop(arg)
    @pointer += 1
  end

  def step
    return :end if @pointer >= @instructions.length
    (inst, arg) = @instructions[@pointer].split
    self.send(inst, arg.to_i)
  end
end

instructions = File.readlines('./input', :chomp => true)

my_gameboy = Gameboy.new(instructions)

pointer_history = [0]
while true
  my_gameboy.step
  if pointer_history.index(my_gameboy.pointer)
    puts my_gameboy.accumulator
    break
  else
    pointer_history.push(my_gameboy.pointer)
    next
  end
end

instructions.each_index do |i|
  if instructions[i][0,3] == 'jmp'
    newinst = instructions.clone.map(&:clone)
    newinst[i].sub!('jmp', 'nop')
  elsif instructions[i][0,3] == 'nop'
    newinst = instructions.clone.map(&:clone)
    newinst[i].sub!('nop', 'jmp')
  else
    next
  end
  my_gameboy = Gameboy.new(newinst)
  pointer_history = [0]
  while true
    if my_gameboy.step == :end
      puts my_gameboy.accumulator
      exit
    elsif pointer_history.index(my_gameboy.pointer)
      break
    else
      pointer_history.push(my_gameboy.pointer)
      next
    end
  end
end
