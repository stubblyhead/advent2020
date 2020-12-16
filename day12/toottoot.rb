class Boat
  attr_reader :lat, :long, :heading

  def initialize()
    @lat, @long = [0,0] #start at origin
    @heading = 90 #initial heading is east
  end

  def move(dir, dist)
    if dir == 'F'  #direction of travel depends on heading, so we'll figure that out now
      case @heading #
      when 0
        dir = 'N'
      when 90
        dir = 'E'
      when 180
        dir = 'S'
      when 270
        dir = 'W'
      end
    end

    case dir  #we know what way to go now, so let's get on with it
    when 'N'
      @lat += dist
    when 'S'
      @lat -= dist
    when 'E'
      @long += dist
    when 'W'
      @long -= dist
    end
  end

  def turn(dir, deg)
    if dir == 'L'  #decreasing angle
      @heading -= deg
    elsif dir == 'R'  #increasing angle
      @heading += deg
    end
    @heading %= 360  #heading
  end
end

moves = File.readlines('./input', :chomp => true)

lollipop = Boat.new
moves.each do |i|
  action = i[0]
  val = i[1..].to_i
  if action == 'R' or action == 'L'
    lollipop.turn(action, val)
  else
    lollipop.move(action, val)
  end
end

puts lollipop.lat.abs + lollipop.long.abs
