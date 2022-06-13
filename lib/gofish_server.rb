require_relative 'gofish_game'
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
        user = @server.accept
        unnamed_sockets.push(user)
        user.puts 'What is your username?'
    end

    def send_output(output, user)
       users.fetch(user).puts output
    end

    def get_user_input(user)
        user.read_nonblock(1000).chomp
        rescue IO::WaitReadable
        retry
    end

    def create_users  
        unnamed_sockets.each do |unnamed_socket|
          username = get_user_input(unnamed_socket)
          users.merge!({ username => unnamed_socket })
          unnamed_sockets.delete(unnamed_socket)
          send_output("Welcome to the game #{username}!", username)
        end
    end
    
    def usernames
       users.keys
    end

     def create_game
       if users.count == 2 
         game = GoFishGame.new(usernames)
       end
       game
     end

    def stop
        @server.close if @server
    end

    def run_go_fish(game)
        runner = GameRunner.new(game, usernames, self)
        runner.start
    end
end