require_relative '../lib/game_runner'
require_relative '../lib/gofish_server'
require_relative '../lib/gofish_game'
require_relative '../lib/gofish_user'
require 'pry'

describe 'GameRunner' do 
  attr_accessor :name1, :name2, :server, :user1, :user2, :game
  before(:each) do
    @users = []
    @server = GoFishServer.new
    @server.start

    @name1 = 'Venus'
    @name2 = 'Poseidon'
    @user1 = GoFishUser.new(server.portnumber)
    @user2 = GoFishUser.new(server.portnumber) 
    sleep(0.01)
    server.accept_user
    server.accept_user
    user1.send_message(name1)
    user2.send_message(name2)
    server.create_users
 
    @game = GoFishGame.new([name1, name2])
end
  
after(:each) do
  @server.stop
  @users.each do |user|
  user.socket.close
  end
end

  describe '#start' do 
  
    let (:runner) { GameRunner.new(game, server.users.keys, server) }
  

    it 'starts a game', :focus do
      spied_game = spy(game) 
      runner1 = GameRunner.new(spied_game, server.users.keys, server)
      expect(spied_game).to receive(:start)
      runner1.start
    end
    it 'lets players know what cards have been dealt' do 
      runner.start
      user1.recieve_message
      user1.recieve_message
      expect(user1.recieve_message).to end_with "You have been dealt #{game.players.fetch(name1).hand}!"
    end
  end
  describe '#run_round' do 
    it 'asks players for a card' do 
        
    end
  end
end