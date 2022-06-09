require 'socket'
require 'pry'
class GoFishServer
    attr_accessor  :unnamed_sockets, :users
    def start
        @server = TCPServer.new portnumber
        @unnamed_sockets = []
        @users = {}
    end

    def portnumber
        3000
    end

    def accept_user
        user = @server.accept_nonblock
        unnamed_sockets.push(user)
        user.puts 'What is your username?'
    end

    def send_output(output, user)
       users.key(user).puts output
    end

    def get_user_input(user)
        user.read_nonblock(1000).chomp
        rescue IO::WaitReadable
        retry
    end

    def create_users
        
        unnamed_sockets.each do |unnamed_socket|
          username = get_user_input(unnamed_socket)
          users.merge!({ unnamed_socket => username })
          unnamed_sockets.delete(unnamed_socket)
          send_output("Welcome to the game #{username}!", username)
        end
    
    end

  

    def stop
        @server.close if @server
    end
end