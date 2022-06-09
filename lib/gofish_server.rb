require 'socket'
class GoFishServer 
    def start
        TCPServer.new portnumber
    end

    def portnumber
        3000
    end
end