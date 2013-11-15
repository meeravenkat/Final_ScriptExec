require 'socket'

port = 2000
SIZE = 1024 * 1024 * 10

server = TCPServer.open(port)
arrFiles = []
puts "Server Listening..."
threads = []
loop {
   while (client = server.accept)
      arrFiles << client
   end
   # arrFiles = reqId.split(",")
p reqId
exit
   thread = Thread.start(server.accept) do |client1|
      puts "the first file is #{arrFiles[0]}"
      File.open("C:/ScriptExecution/Stations/A/Meera/#{arrFiles[0]}", "w") do |file|
         while chunk = client1.read(SIZE)
            # p chunk
            file.write(chunk)
         end
      end
   end

   thread = Thread.start(server.accept) do |client2|
      puts "the second file is #{arrFiles[1]}"
      File.open("C:/ScriptExecution/Stations/A/Meera/#{arrFiles[1]}", "w") do |file1|
         while chunk = client2.read(SIZE)
            # p chunk
            file1.write(chunk)
         end
      end
   end

   # threads << thread
}
# client.close

# threads.each do |thread| 
#    p "exec begins here"
#    thread.join
# end