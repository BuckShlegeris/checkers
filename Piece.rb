class Piece
  attr_accessor :x, :y, :color

  def initialize(x, y, color, board)
    @x, @y, @color = x, y, color

    if color == :white
      @dy = -1
    else
      @dy = 1
    end

    @promoted = false
    @board = board
  end

  def promoted?
    @promoted
  end

  def perform_slide(new_x,new_y)
    return false unless (new_x - @x).abs == 1

    if promoted? # If you're promoted, you can go backwards
      return false unless (new_y - @y).abs == 1
    else
      return false unless @y + @dy == new_y
    end

    return false unless @board[[new_x, new_y]].nil?

    move!(new_x,new_y)

    return true
  end

  def perform_jump(new_x,new_y)
    return false unless (new_x - @x).abs == 2

    if promoted? # If you're promoted, you can go backwards
      return false unless (new_y - @y).abs == 2
    else
      return false unless @y + @dy*2 == new_y
    end

    thing_we_jump_over = @board[[(x+new_x) / 2, (y+new_y) / 2]]

    return false if thing_we_jump_over.nil?
    return false if thing_we_jump_over.color == self.color

    @board[[(x+new_x) / 2, (y+new_y) / 2]] = nil

    move!(new_x,new_y)

    return true
  end

  def move!(new_x, new_y)
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