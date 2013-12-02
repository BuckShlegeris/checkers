require "./Board.rb"
require "./Human_Player.rb"

class Game
  def play(player1, player2)
    board = Board.new
    player = player1
    color = :white

    until board.done?
      board.render

      start, sequence = player.get_move

      starting_piece = board[start]
      if starting_piece || starting_piece.color = color
        board[start].perform_moves(sequence)
      end

      if color == :white
        color = :black
        player = player2
      else
        color = :white
        player = player1
      end
    end
  end
end

g = Game.new
g.play(HumanPlayer.new, HumanPlayer.new)