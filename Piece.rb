# encoding : utf-8

class Piece
  attr_accessor :pos, :color

  def initialize(pos, color, board)
    @pos, @color = pos, color

    if color == :white
      @dy = 1
    else
      @dy = -1
    end

    @promoted = false
    @board = board
  end

  def promoted?
    @promoted
  end

  def to_s
    if promoted?
      return "☗ "
    else
      return "☻ "
    end
  end

  def perform_slide(new_pos)
    x, y = @pos
    new_x, new_y = new_pos

    return false unless (new_x - x).abs == 1

    if promoted? # If you're promoted, you can go backwards
      return false unless (new_y - y).abs == 1
    else
      return false unless y + @dy == new_y
    end

    return false unless @board[new_pos].nil?

    move!(new_pos)

    true
  end

  def perform_jump(new_pos)
    x, y = @pos
    new_x, new_y = new_pos

    return false unless (new_x - x).abs == 2

    if promoted? # If you're promoted, you can go backwards
      return false unless (new_y - y).abs == 2
    else
      return false unless y + @dy * 2 == new_y
    end

    thing_we_jump_over = @board[[(x+new_x) / 2, (y+new_y) / 2]]

    return false if thing_we_jump_over.nil?
    return false if thing_we_jump_over.color == self.color

    @board[[(x+new_x) / 2, (y+new_y) / 2]] = nil

    move!(new_pos)

    true
  end

  def move!(new_pos)
    @board[pos] = nil
    @board[new_pos] = self
    self.pos = new_pos

    maybe_promote
  end

  def maybe_promote
    y = @pos[1]
    if y == 0 && color == :white || y == 7 && color == :black
      promoted = true
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.length == 1
      if perform_slide(move_sequence.first)
        return
      end
    end

    move_sequence.each do |move|
      raise InvalidMoveException unless perform_jump(move)
    end
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveException
    end
  end

  def valid_move_seq?(move_sequence)
    new_board = @board.dup
    old_board = @board
    old_pos = pos.dup
    old_promoted = promoted?

    @board = new_board
    begin
      perform_moves!(move_sequence)
    rescue InvalidMoveException
      out = false
    else
      out = true
    end

    @board = old_board
    @pos = old_pos
    @promoted = old_promoted

    out
  end
end


class InvalidMoveException < RuntimeError
end