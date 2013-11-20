require 'socket'

hostname = 'localhost'
port = 2000
SIZE = 1024 * 1024 * 10

arrFiles = []
server = TCPSocket.open(hostname, port)
dir_path = "C:/p4/workspaces/balapax_ILL96061F/test/plumtest/15_0/DEV/PadmapriyaB/automation/TestScripts/DID-SWFU/Functional_Requirements/Programming/Order_Entry_Calculation_Rules"
files    = "PL-DID-SWFU-2785.rb,PL-DID-SWFU-2785.xml"
server.write(files)
arrFiles = files.split(",")

arrFiles.each do |arrFile|
   TCPSocket.open(hostname, port) do |server1|
      p "client 1"
      File.open("#{dir_path}/#{arrFile}") do |file|
         while chunk = file.read(SIZE)
            server1.write(chunk)
         end
      end
   end
end