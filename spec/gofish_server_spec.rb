require_relative '../lib/gofish_server'
require_relative '../lib/gofish_user'
require 'pry'

describe '#GoFishServer' do 
    before(:each) do
        @users = []
        @server = GoFishServer.new
        @server.start
    end
    
    after(:each) do
        @server.stop
        @users.each do |user|
          user.socket.close
        end
    end

    let!(:user1) { GoFishUser.new(@server.portnumber)}
    let!(:user2) { GoFishUser.new(@server.portnumber)}


    describe '#accepts_user' do 
        it 'assigns the accepted users to unnamed_sockets' do
            @users.push(user1, user2)
            @server.accept_user
            expect(@server.unnamed_sockets.count).to eq 1
            @server.accept_user
            expect(@server.unnamed_sockets.count).to eq 2
        end

        it 'outputs messages to players' do          
            @users.push(user1)
            @server.accept_user
            expect(user1.recieve_message).to eq 'What is your username?'
        end
    end

    describe '#creates_users' do 
        it 'adds a name and socket to the user hash if a player has been created' do 
           @users.push(user1)
           @server.accept_user
           user1.send_message('Warp')
           @server.create_users
           expect(@server.users.values).to eq ['Warp']   
      end

      it 'can send a message to a user given the players name', :focus do 
        name = 'Warp'
        @users.push(user1)
        @server.accept_user
        user1.recieve_message
        user1.send_message(name)
        @server.create_users    
        expect(user1.recieve_message).to eq 'Welcome to the game Warp!'
      end
    end
end