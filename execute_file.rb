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
optionsList = ARGV[0].to_s

#----------------
# Handle the args
if (ARGV.empty?)
   puts "No arguments provided"
   exit
else
   server = TCPSocket.open(HOSTNAME, PORT)
   server.write(optionsList)
end

#-----------
# Parse ARGV
optionsListArr = []
optionsListArr = optionsList.split(',')
FILES_ARR = optionsListArr.pop(2)
STATIONNAME = optionsListArr.first
p STATIONNAME
p FILES_ARR

#-----------------------------------
# Write the first file to the server
TCPSocket.open(HOSTNAME, PORT) do |server1|
   File.open("#{CURRENT_WORKING_DIR}/#{FILES_ARR.first}") do |file|
      while chunk = file.read(SIZE)
         server1.write(chunk)
      end
   end
end

#------------------------------------
# Write the second file to the server
TCPSocket.open(HOSTNAME, PORT) do |server2|   
   File.open("#{CURRENT_WORKING_DIR}/#{FILES_ARR.last}") do |file1|
      while chunk = file1.read(SIZE)
         server2.write(chunk)
      end
   end
end