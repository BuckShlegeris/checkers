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
    raise "invalid index" unless x.between?(0,7) && y.between(0,7)

    @grid[y][x]
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
      puts ""
    end
  end

  def add_piece(x, y, color)
    p = Piece.new(x, y, color, self)
    @grid[y][x] = p
  end
end

b= Board.new
b.render
b.add_piece(3,3,:white)
b.render