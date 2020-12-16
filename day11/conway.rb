#RIP john conway


class WaitingRoom

  def initialize(grid)
    @grid = grid
  end

  def count_seated
    seated = 0
    @grid.each do |row|
      seated += row.count('#')
    end
    return seated
  end

  def count_adjacent(row,col)
    adj = 0
    (row-1..row+1).each do |i|  #iterate from preceding row to next row
      next if i == -1 or i == @grid.length #skip as needed on first and last rows
      (col-1..col+1).each do |j|  #iterate from preceding col to next col
        next if j == -1 or j == @grid[row].length  #skip as needed on first and last cols
        adj += 1 if @grid[i][j] == '#' unless i == row and j == col #seats are not adjacent to themselves
      end
    end
    return adj
  end

  def count_visible(row,col)
    adj = 0
    look_row,look_col = [row,col]  #need to manipulate col and row, but also keep track of what seat we're starting from.  there's probably a better way to do this
    until look_row == 0 #looking north
      look_row -= 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L' #only the first visible seat counts
    end

    look_row = row
    until look_row == @grid.length - 1 #looking south
      look_row += 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end

    look_row = row
    until look_col == 0 #looking west
      look_col -= 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end

    look_col = col
    until look_col == @grid[row].length - 1 #looking east
      look_col += 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end

    look_col = col
    until look_row == 0 or look_col == 0 #looking northwest
      look_row -= 1
      look_col -= 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end

    look_row,look_col = [row,col]
    until look_row == @grid.length - 1 or look_col == @grid[row].length - 1 #looking southeast
      look_row += 1
      look_col += 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end

    look_row, look_col = [row,col]
    until look_row == 0 or look_col == @grid[row].length - 1 #looking northeast
      look_row -= 1
      look_col += 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end

    look_row, look_col = [row,col]
    until look_row == @grid.length - 1 or look_col == 0 #looking southwest
      look_row += 1
      look_col -= 1
      if @grid[look_row][look_col] == '#'
        adj += 1
        break
      end
      break if @grid[look_row][look_col] == 'L'
    end
    return adj
  end

  def sit(look = false)
    look ? func = "count_visible" : func = "count_adjacent" #set which function to call later based on input parm
    to_change = [] #can't change as we go, need to check every seat first then change
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        if @grid[row][col] == 'L'
          to_change.push([row,col]) if self.send(func,row,col) == 0 #add to the change list if all adjacent seats are empty
        end
      end
    end
    to_change.each do |i|
      (row,col) = i
      @grid[row][col] = '#'
    end
    return to_change.length  #return the number of seats whose state changed
  end

  def stand(look = false)
    if look
      func = "count_visible"
      tolerance = 5
    else
      func = "count_adjacent"
      tolerance = 4
    end
    to_change = []
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        if @grid[row][col] == '#'
          to_change.push([row,col]) if self.send(func,row,col) >= tolerance #add to change list if four or more adjacent seats are occupied
        end
      end
    end
    to_change.each do |i|
      (row,col) = i
      @grid[row][col] = 'L'
    end
    return to_change.length  #return number of seats whose state changed
  end
end

seats = File.readlines('./testcase', :chomp => true).map { |i| i.split('') }
room = WaitingRoom.new(seats)
while true
  change = room.sit
  if change == 0
    puts room.count_seated
    break
  end

  change = room.stand
  if change == 0
    puts room.count_seated
    break
  end
end

seats = File.readlines('./testcase', :chomp => true).map { |i| i.split('') }
room = WaitingRoom.new(seats)
puts seats[0]
while true
  change = room.sit(look = true)
  if change == 0
    puts room.count_seated
    break
  end

  change = room.stand(look = true)
  if change == 0
    puts room.count_seated
    break
  end
end
