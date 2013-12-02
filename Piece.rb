class Piece
  attr_accessor :x, :y, :color

  def initialize(x, y, color, board)
    @x, @y, @color = x, y, color
    @promoted = false
    @board = board
  end

  def promoted?
    promoted
  end

  def perform_slide(new_x,new_y)
    return false if abs(new_x - @x) != 1 || abs(new_y - @y) != 1
    return false if @board[[new_x, new_y]] != nil

    @board[[x, y]] = nil
    @board[[new_x, new_y]] = self
    self.x, self.y = new_x, new_y

    maybe_promote
  end

  def maybe_promote
    if y == 0 && color == :white || y == 7 && color == :black
      promoted = true
    end
  end

end