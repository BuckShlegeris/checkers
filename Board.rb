# encoding : utf-8

require_relative "Piece.rb"
require "colorize"

class Board
  attr_accessor :grid

  def initialize(fill_board = true)
    if fill_board
      populate_board
    end
  end

  def populate_board
    @grid = Array.new(8) { Array.new(8, nil) }

    [1,3,5,7].each do |x|
      [0,2].each do |y|
        @grid[y][x] = Piece.new([x,y], :white, self)
        @grid[7-y][7-x] = Piece.new([7-x,7-y], :black, self)
      end
    end

    [0,2,4,6].each do |x|
      @grid[1][x] = Piece.new([x,1], :white, self)
      @grid[6][7-x] = Piece.new([7-x,6], :black, self)
    end
  end

  def [](pos)
    x, y = pos
    raise "invalid index" unless x.between?(0, 7) && y.between?(0, 7)

    @grid[y][x]
  end

  def []=(pos,value)
    x,y = pos
    raise "invalid index" unless x.between?(0, 7) && y.between?(0, 7)

    @grid[y][x] = value
  end

  def render
    puts "  0 1 2 3 4 5 6 7"
    @grid.each_with_index do |row, y|
      print y
      row.each_with_index do |item, x|
        this_char = item.to_s
        if item.nil?
          this_char = "  "
        elsif item.color == :white
          this_char = this_char.white
        else
          this_char = this_char.black
        end

        if (x + y) % 2 == 0
          this_char = this_char.on_green
        else
          this_char = this_char.on_red
        end

        print this_char

      end
      puts
    end
    puts
  end

  def add_piece(pos, color)
    p = Piece.new(pos, color, self)
    self[pos] = p
  end

  def dup
    out = Board.new(false)
    out.grid = []

    @grid.each do |row|
      new_row = []
      row.each do |piece|
        if piece.nil?
          new_row << nil
        else
          new_row << Piece.new(piece.pos, piece.color, out)
        end
      end
      out.grid << new_row
    end

    out
  end

  def done?
    pieces = @grid.flatten.map { |x| x.nil? ? [] : x.color }.flatten
    ! (pieces.include?(:white) || pieces.include?(:black))
  end

end
