require 'socket'
require 'pry'
class GoFishUser
    attr_reader :socket
    def initialize(port)
        @socket = TCPSocket.new('localhost', port)
        sleep(0.1)
    end

    def send_message(message)
        socket.puts message
    end

    def recieve_message
        socket.read_nonblock(1000).chomp
        rescue IO::WaitReadable
        retry
    end
end