#RIP john conway
require 'pry'
binding.pry

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
    [row-1..row+1].each do |i|  #iterate from preceding row to next row
      next if i == -1 or i == @grid.length #skip as needed on first and last rows
      [col-1..col+1].each do |j|  #iterate from preceding col to next col
        next if col == -1 or col == @grid[row].length  #skip as needed on first and last cols
        adj += 1 if @grid[row][col] == '#'
      end
    end
    return adj
  end

  def sit
    to_change = [] #can't change as we go, need to check every seat first then change
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        if @grid[row][col] == 'L'
          to_change.push([row,col]) if count_adjacent(row,col) == 0 #add to the change list if all adjacent seats are empty
        end
      end
    end
    to_change.each do |i|
      (row,col) = i
      @grid[row][col] == '#'
    end
    return to_change.length  #return the number of seats whose state changed
  end

  def stand
    to_change = []
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        if @grid[row][col] == '#'
          to_change.push([row,col]) if count_adjacent(row,col) >= 4 #add to change list if four or more adjacent seats are occupied
        end
      end
    end
    to_change.each do |i|
      (row,col) = i
      @grid[row][col] == 'L'
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
