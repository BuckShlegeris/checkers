require_relative "Piece.rb"

class Board
  attr_accessor :grid

  def initialize(fill_board = true)
    if fill_board
      @grid = Array.new(8) { Array.new(8,nil) }
      # TODO: this needs to actually put pieces down
    end
  end

  def [](pos)
    x,y = pos
    raise "invalid index" unless x.between?(0,7) && y.between?(0,7)

    @grid[y][x]
  end

  def []=(pos,value)
    x,y = pos
    raise "invalid index" unless x.between?(0,7) && y.between?(0,7)

    @grid[y][x] = value
  end

  def render
    @grid.each do |row|
      row.each do |item|
        if item.nil?
          print "."
        elsif item.color == :white
          print "w"
        else
          print "b"
        end
      end
      puts
    end
    puts
  end

  def add_piece(x, y, color)
    p = Piece.new(x, y, color, self)
    @grid[y][x] = p
  end
end

b= Board.new
b.add_piece(3,5,:white)
b.add_piece(2,4,:black)
b.render
p b[[3,5]].perform_jump(1,3)
b.render