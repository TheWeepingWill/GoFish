require_relative '../lib/gofish_server'
require_relative '../lib/gofish_user'

describe '#GoFishServer' do 
    RSpec::Expectations.configuration.on_potential_false_positives = :nothing
    before(:each) do
        @users = []
        @server = GoFishServer.new
      end
    
      after(:each) do
        @server.stop
        @users.each do |client|
          client.close
        end
      end

      let (:user1) { GoFishUser.new(@server.portnumber)}
      let (:user2) { GoFishUser.new(@server.portnumber)}

    it 'starts' do 
       expect { @server.start }.not_to raise_error
    end

    # xit 'recieves messages from players' do 
    #     @server.start
    #     user1.send_message('Hello Server')
    #     expect(@server.get_message(****)).to eq 'Hello Server' 
    # end

    it 'outputs messages to players' do 
        @server.start
        user1
        @server.accept_users
        expect(user1.recieve_message).to eq 'What is your username?'
    end
end