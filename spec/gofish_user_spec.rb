require_relative '../lib/gofish_user'
require_relative '../lib/gofish_server'

describe '#GoFishUser' do 
  let (:server) { GoFishServer.new }
  let (:user) { GoFishUser.new(server.portnumber) }
   it 'can connect to a server' do 
      expect { user }.to raise_error('Could not Connect to the Server')
      server.start
      expect { user }.not_to raise_error
   end
end