require 'socket'
require 'pry'
class GoFishUser
PORT_NUMBER = 3000
    attr_reader :socket
    def initialize(port = PORT_NUMBER)
        @socket = TCPSocket.new('localhost', port)
        sleep(0.1)
    rescue Errno::ECONNREFUSED
        raise StandardError.new 'Could not Connect to the Server'
    end

    def send_message(message)
        socket.puts message
    end

    def recieve_message
        puts socket.gets.chomp.gsub(/\R+/, ' ')
    end

    def script
      while true 
       recieve_message
    #    name = gets
    #    send_message(name)
    #    recieve_message 
    #    recieve_message  
      end
    end
end

