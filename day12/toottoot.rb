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

class Boat2 < Boat
  def initialize
    @wp_lat, @wp_long = [1, 10]  #wp coords are relative to boat
    @lat, @long = [0,0]
  end

  def normalize(dir, deg)
    deg %= 360
    if deg == 270
      deg = 90
      if dir == 'R'
        dir = 'L'
      elsif dir == 'L'
        dir = 'R'
      end
    end
    return [dir, deg]
  end

  def turn(dir, deg)
    (dir, deg) = normalize(dir,deg)
    if deg == 180  #negate both x and y
      @wp_lat = -@wp_lat
      @wp_long = -@wp_long
    elsif dir == 'R' #swap x and y, negate y
      tmp = @wp_lat
      @wp_lat = @wp_long
      @wp_long = tmp
      @wp_lat = -@wp_lat
    elsif dir == 'L' #swap x and y, negate x
      tmp = @wp_lat
      @wp_lat = @wp_long
      @wp_long = tmp
      @wp_long = -@wp_long
    end
  end

  def move(dir, dist)
    case dir
    when 'N'
      @wp_lat += dist
    when 'E'
      @wp_long += dist
    when 'S'
      @wp_lat -= dist
    when 'W'
      @wp_long -= dist

    when 'F'
      @lat += dist * @wp_lat
      @long += dist * @wp_long
    end
  end
end

kobayashi_maru = Boat2.new
moves.each do |i|
  action = i[0]
  val = i[1..].to_i
  if action == 'R' or action == 'L'
    kobayashi_maru.turn(action, val)
  else
    kobayashi_maru.move(action, val)
  end
end

puts kobayashi_maru.lat.abs + kobayashi_maru.long.abs
