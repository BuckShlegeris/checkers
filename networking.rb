require 'socket'      # Sockets are in standard library

$hostname = '10.0.1.154' #'199.241.200.213'
$port = 8081

def client
  begin
    server = TCPSocket.open($hostname, $port)
  rescue => error
 #   puts error
    retry
  end

  server
end

def server
  server = TCPServer.open($port)
  server.accept
end

def recv(place)
  STDOUT.puts "recv"
  x = place.recv(100)
  place.close
  x
end

def send_msg(place,str)
  STDOUT.puts "send"
  place.send(str,0)
  STDOUT.puts "recv done"
  place.close
end