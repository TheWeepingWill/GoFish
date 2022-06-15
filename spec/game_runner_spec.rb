require_relative '../lib/game_runner'
require_relative '../lib/gofish_server'
require_relative '../lib/gofish_game'
require_relative '../lib/gofish_user'
require 'pry'

describe 'GameRunner' do 
  class MockUser
    def receive_message

    end
  end

  attr_accessor :name1, :name2, :server, :user1, :user2, :game, :users
  before(:each) do
    @users = []
    @server = GoFishServer.new
    server.start

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
    server.create_users
 
    @game = GoFishGame.new([name1, name2])
end
  
after(:each) do
  server.stop
  users.each do |user|
  user.socket.close
  end
end
let (:runner) { GameRunner.new(game, server.users.keys, server) }

  describe '#start' do 

    it 'starts a game' do
      spied_game = spy(game) 
      runner1 = GameRunner.new(spied_game, server.users.keys, server)
      expect(spied_game).to receive(:start)
      runner1.start
    end

    
    it 'lets players know what cards have been dealt' do 
      hand = game.get_player(name1).hand.map{ |card| card.to_s }
      runner.start
      user1.recieve_message
      user1.recieve_message
      expect(user1.recieve_message).to eq "Your starting hand is #{hand}"
    end
  end
  
  describe '#run_game' do 
    # it 'requests rank of card', :focus do
    #   runner.start
    #   until user1.recieve_message.nil?
    #     binding.pry
    #   end
    #   starter = runner.game.current
    #   user1.send_message('3')
    #   user1.send_message(name2)
    #   runner.run_game
    #   expect(user1.recieve_message.first).to eq 'What rank of card would you like to request:'
    # end

    # it 'requests a target_player' do 
    #   runner.start
    #   until user1.recieve_message.nil?
    #     user1.recieve_message
    #   end
    #   starter = runner.current_player?
    #   user1.send_message('3')
    #   user1.send_message(name2)
    #   runner.run_game
    #   user1.recieve_message
    #   expect(user1.recieve_message).to eq 'What player would you like to request from:'
    
    # end

      it 'if the targeting player doesnt have cards the current player goes fish' do
          # given 
          # runner.start
          
             #, a player has requested cards and 
             # a target player and that a player does not have the requested cards
          # when the round is run 
          # then the asking player recieves "go fish"

      end

  end


end