require_relative '../lib/gofish_server'
require_relative '../lib/gofish_user'
require 'pry'

describe '#GoFishServer' do 
  attr_accessor :users, :server, :user1, :user2
  before(:each) do
      @users = []
      @server = GoFishServer.new
      server.start
      @user1 = GoFishUser.new(server.portnumber)
      @user2 = GoFishUser.new(server.portnumber)
  end
    
  after(:each) do
    server.stop
    users.each do |user|
    user.socket.close
    end
  end

    def create_server_game
        users.push(user1, user2) 
        server.accept_user
        user1.recieve_message
        user1.send_message('Johan')
        server.create_users 
        user1.recieve_message
        server.accept_user
        user2.send_message('Yor')
        server.create_users
        user2.recieve_message
        server.create_game
  end

  describe '#accepts_user' do 
    it 'assigns the accepted users to unnamed_sockets' do
      users.push(user1, user2)
      server.accept_user
      expect(server.unnamed_sockets.count).to eq 1
       server.accept_user
      expect(server.unnamed_sockets.count).to eq 2
    end

    it 'outputs messages to players' do          
        users.push(user1)
        server.accept_user
        expect(user1.recieve_message).to eq 'Input your Username:'
    end
  end

  describe '#creates_users' do 
    it 'adds a name and socket to the user hash if a player has been created' do 
       users.push(user1)
        server.accept_user
        user1.send_message('Warp')
        server.create_users
        expect(server.users.keys).to eq ['Warp']   
    end

    it 'can send a message to a user given the players name' do 
      name = 'Warp'
     users.push(user1)
      server.accept_user
      user1.recieve_message
      user1.send_message(name)
      server.create_users    
      expect(user1.recieve_message).to eq 'Welcome to the game Warp!'
    end
  end

  describe '#create_game' do 
    it 'does not create a game with a single user' do 
       users.push(user1) 
        server.accept_user
        user1.recieve_message
        user1.send_message('Josh')
        server.create_users 
        server.create_game
        expect(server.create_game).to be nil  
    end

    it 'creates a game when two users are available' do 
      create_server_game
      expect(server.create_game).to be_a_kind_of(GoFishGame) 
    end
  end

  describe '#run_go_fish' do 
     it 'tells players their hand' do
      game = create_server_game
      server.run_go_fish(game)
      expect(user1.recieve_message).to eq "Your starting hand is #{game.get_player('Johan').hand}"
     end
  end
end