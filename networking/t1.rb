$hostname = '10.0.1.154' #'199.241.200.213'
$port = 8081

begin
  socket = TCPSocket.open($hostname, $port)
rescue => error
  retry
end

while true
  puts socket.gets
  socket.puts "lol"
end