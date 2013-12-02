require "./Board.rb"
require "./Human_Player.rb"
require 'socket'

$hostname = '10.0.1.154' #'199.241.200.213'
$port = 8081

class Game
  def play(mode)
    board = Board.new
    color = :white

    socket = get_socket(mode)

    puts "lol"

    until board.done?
      board.render

      if (mode == :server) == (color == :white)
        data = STDIN.gets.chomp
        socket.puts(data)
      else
        data = socket.gets
      end

      start, sequence = eval(data)

      starting_piece = board[start]
      if starting_piece || starting_piece.color = color
        board[start].perform_moves(sequence)
      end

      if color == :white
        color = :black
      else
        color = :white
      end
    end
  end

  def get_socket(mode)
    if mode == :server
      server = TCPServer.open($port)
      socket = server.accept
    else
      begin
        socket = TCPSocket.open($hostname, $port)
      rescue => error
        retry
      end
    end
    socket
  end
end

g = Game.new
g.play(ARGV[0].to_sym)