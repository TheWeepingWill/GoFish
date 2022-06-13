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
    # binding.pry
    game.start
    player_names.each do |player|
      server.send_output(
        "You have been dealt #{game.players.fetch(player).hand}!",
        player
      )
      game
    end

   end
   
   def run_game
      
   end

end