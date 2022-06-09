require 'socket'
require 'pry'
class GoFishServer
    attr_accessor  :unnamed_sockets, :users
    def start
        @server = TCPServer.new portnumber
        @unnamed_sockets = []
    end

    def portnumber
        3000
    end

    def accept_user
        user = @server.accept_nonblock
        unnamed_sockets.push(user)
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

    def create_users
        @users = {}
        unnamed_sockets.each do |unnamed_user|
          users.merge!({ unnamed_user => get_user_input(unnamed_user) })
        end
    end

  

    def stop
        @server.close if @server
    end
end