require_relative 'gofish_server'
require_relative 'game_runner'
require 'pry'

server = GoFishServer.new
server.start
while server
begin
  server.accept_user
  server.create_users
  game = server.create_game
  if game 
    server.run_go_fish(game)
    # binding.pry
  end
rescue => error
  server.stop 
  binding.pry
end
end

