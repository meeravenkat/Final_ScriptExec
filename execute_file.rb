#!/usr/bin/env ruby

#-----------------
# Require the gems
require 'socket'
require 'awesome_print'
require 'optparse'

#----------------------
# Declare the constants
HOSTNAME = 'localhost'
PORT = 2000
SIZE = 1024 * 1024 * 10
CURRENT_WORKING_DIR = Dir.pwd

#---------------------------------------------------------------------------
# Create options to get from user and store them in Options hash as an Array
options = {}
OptionParser.new do |opts|
   opts.banner = "Usage: script_execution.rb [-l station_name,rb_file,xml_file]"
   opts.on("-l", "--list stationName,.rb file,.xml file", Array, \
           "Example: -l A,PL-UIDDA-1784.rb,PL-UIDDA-1784.xml") do |list|
      options[:params] = list
   end
   opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
   end
end.parse(ARGV)

#----------------
# Handle the args
arrList = []
arrFiles = []
arrList = options[:params]
if (arrList.nil?) or (arrList.empty?)
   puts "No arguments provided"
   exit
else
   server = TCPSocket.open(HOSTNAME, PORT)
   arrFiles = arrList.pop(2)
   stationName = arrList.first
   arrList.each do |element|
      p "inarra"
      server.write(element)
   end
exit
   #-----------------------------------
   # Write the first file to the server
   TCPSocket.open(HOSTNAME, PORT) do |server1|
      File.open("#{CURRENT_WORKING_DIR}/#{arrFiles.first}") do |file|
         while chunk = file.read(SIZE)
            server1.write(chunk)
         end
      end
   end

   #------------------------------------
   # Write the second file to the server
   TCPSocket.open(HOSTNAME, PORT) do |server2|   
      File.open("#{CURRENT_WORKING_DIR}/#{arrFiles.second}") do |file1|
         while chunk = file1.read(SIZE)
            server2.write(chunk)
         end
      end
   end
end # End of if Condition
