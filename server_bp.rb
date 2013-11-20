require 'socket'

port = 2000
SIZE = 1024 * 1024 * 10

server = TCPServer.open(port)
arrFiles = []
puts "Server Listening..."
threads = []
loop {
   client = server.accept
   reqId = client.gets
   arrFiles = reqId.split(",")
   puts "file names are #{arrFiles[0]}, #{arrFiles[1]}"

   arrFiles.each do |arrFile|
      Thread.fork(server.accept) do |client1|
         puts "the first file is #{arrFile}"
         File.open("C:/ScriptExecution/Stations/A/padma/#{arrFile}", "w") do |file|
            while chunk = client1.read(SIZE)
               file.write(chunk)
            end
         end

         if (arrFiles.last.eql? arrFile)
            root_dir = Dir.pwd
            puts root_dir
            Dir.chdir("C:/ScriptExecution/Stations/A/padma")
            puts Dir.pwd

            pathName = "C:/ScriptExecution/Stations/A/padma/#{arrFiles[0]}"
            system "ruby #{pathName}"

            Dir.chdir(root_dir)
            puts Dir.pwd
         end
      end
   end
}