port = 2000
SIZE = 1024 * 1024 * 10

puts "Server Listening..."
server = TCPServer.open(port)

loop do
   client = server.accept
   optionsList = client.gets
   optionsListArr = optionsList.split(',')
   FILES_ARR = optionsListArr.pop(2)
   STATIONNAME = optionsListArr.first
   
FILES_ARR.each do |arrFile|
      Thread.fork(server.accept) do |client1|
         puts "the first file is #{arrFile}"
         File.open("M:/Script Execution/Stations/#{STATIONNAME}/meera/#{arrFile}", "w") do |file|
            while chunk = client1.read(SIZE)
               file.write(chunk)
            end
         end

         # if (FILES_ARR.last.eql? arrFile)
         #    Dir.chdir("M:/ScriptExecution/Stations/#{STATIONNAME}/meera")
         #    puts Dir.pwd
         #    pathName = "M:/ScriptExecution/Stations/#{STATIONNAME}/meera/#{arrFile}"
         #    system "ruby #{pathName}"
         #    Dir.chdir(root_dir)
         #    puts Dir.pwd
         # end
      end
   end
end































   # thread = Thread.start(server.accept) do |client1|
   #    puts "the first file is #{arrFiles[0]}"
   #    File.open("C:/ScriptExecution/Stations/A/Meera/#{arrFiles[0]}", "w") do |file|
   #       while chunk = client1.read(SIZE)
   #          # p chunk
   #          file.write(chunk)
   #       end
   #    end
   # end

   # thread = Thread.start(server.accept) do |client2|
   #    puts "the second file is #{arrFiles[1]}"
   #    File.open("C:/ScriptExecution/Stations/A/Meera/#{arrFiles[1]}", "w") do |file1|
   #       while chunk = client2.read(SIZE)
   #          # p chunk
   #          file1.write(chunk)
   #       end
   #    end
   # end

   # threads << thread
# }
# client.close

# threads.each do |thread| 
#    p "exec begins here"
#    thread.join
# end