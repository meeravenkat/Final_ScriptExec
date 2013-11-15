require 'socket'

hostname = 'localhost'
port = 2000
SIZE = 1024 * 1024 * 10
CWD = Dir.pwd

# server = TCPSocket.open(hostname, port)

# send = server.puts("dir")
# response = server.read
# puts response

# server.close
arrFiles = []
server = TCPSocket.open(hostname, port)
dir_path = 'C:\p4\test\plumtest\15_0\DEV\MeeraV\automation\TestScripts\DDA\S31'
files = "PL-DDA-180.rb,PL-DDA-180.xml"
server.write(files)
arrFiles = files.split(",")

TCPSocket.open(hostname, port) do |server1|
   File.open("#{dir_path}/#{arrFiles[0]}") do |file|
      while chunk = file.read(SIZE)
         server1.write(chunk)
      end
   end
end
TCPSocket.open(hostname, port) do |server2|   
   File.open("#{dir_path}/#{arrFiles[1]}") do |file1|
      while chunk = file1.read(SIZE)
         server2.write(chunk)
      end
   end
end