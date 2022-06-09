require 'socket'
class GoFishServer
    attr_accessor  :unnamed_users
    def start
        @server = TCPServer.new portnumber
        @unnamed_users = []
    end

    def portnumber
        3000
    end

    def accept_users
        user = @server.accept
        unnamed_users.push(user)
        send_ouput('What is your username?', user)
    end

    def send_ouput(output, user)
       user.puts output
    end

    def get_user_input(user)
        user.read_nonblock(1000).chomp
        rescue IO::WaitReadable
        retry
    end

    def stop
        @server.close if @server
    end
end