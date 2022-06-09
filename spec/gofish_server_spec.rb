require_relative '../lib/gofish_server'
require_relative '../lib/gofish_user'
require 'pry'

describe '#GoFishServer' do 
    RSpec::Expectations.configuration.on_potential_false_positives = :nothing
    before(:each) do
        @users = []
        @server = GoFishServer.new
        @server.start
      end
    
      after(:each) do
        @server.stop
        @users.each do |user|
          user.close
        end
      end

      let!(:user1) { GoFishUser.new(@server.portnumber)}
      let!(:user2) { GoFishUser.new(@server.portnumber)}

    it 'starts' do 
       expect { @server.start }.not_to raise_error
    end
    describe '#accepts_user' do 
        it 'assigns the accepted users to unnamed_sockets' do 
            user1
            @users.push
            @server.accept_user
            expect(@server.unnamed_sockets.count).to eq 1
            user2
            @users.push
            @server.accept_user
            expect(@server.unnamed_sockets.count).to eq 2
        end



        it 'outputs messages to players' do          
            user1
            @users.push
            @server.accept_user
            expect(user1.recieve_message).to eq 'What is your username?'
        end
    end

    describe '#creates_users' do 
        it 'add to username' do
            user1
            @users.push
            @server.accept_user
            expect(@server.unnamed_sockets.count).to eq 1  
            user.send_message('Guardian')
            @server.create_users 
            expect(@server.username).to       
        end
        it 'add to sockets' do
            user1
            @users.push
            @server.accept_user
            expect(@server.unnamed_sockets.count).to eq 1  
            user.send_message('Guardian')
            @server.create_users 
            expect(@server.username).to       
        end
    end
end