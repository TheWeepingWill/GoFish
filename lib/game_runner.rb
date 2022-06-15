require_relative 'gofish_server'
require_relative 'gofish_user'
require_relative 'gofish_game'
require 'pry'
class GameRunner
  attr_accessor :player_names, :game, :server

   def initialize(game, player_names, server)
    @game = game
    @player_names = player_names
    @server = server
   end
   
   def start
     
    game.start
    player_names.each do |player|
      server.send_output(
        "Your starting hand is #{game.get_player(player).hand.map { |card| card.to_s }}",
        player
      )
    end

   end
   
   def run_game
      until game.over?
        get_paramaters_and_play_round
      end
      message_to_all('Game is over!')
   end

   def   current_player
      game. current_player
   end

   def get_paramaters_and_play_round
    current_user.puts 'What rank of card would you like to request:'
    rank =  server.get_user_input(current_user)
    current_user.puts 'What player would you like to request from:'
    target = server.get_user_input(current_user)
    round =  game.play_round(  current_player, rank, target)
    if round 
      current_user.puts("#{target} did not have any #{rank}s Go Fish!")
    end
    if  round
       acquired_card = game.get_player( current_player).hand.last
       current_user.puts("You went fishing and got a #{acquired_card.to_s}")
    end

   end

   def message_to_all(message)
      server.sockets.each { |socket| socket.puts message }
   end
   
   def current_user 
    server.users.fetch( current_player)
   end


end