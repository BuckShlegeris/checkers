$hostname = '10.0.1.154' #'199.241.200.213'
$port = 8081

server = TCPServer.open($port)
socket = server.accept

while true
  socket.puts "lol2"
  puts socket.gets
end