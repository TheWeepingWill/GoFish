require_relative '../lib/gofish_server_user'
require_relative '../lib/gofish_server'

describe '#GoFishUser' do 
    let (:server) { GoFishServer.new }
    let (:player) { GoFishUser.new }
   it 'can connect to a server' do 
       expect(player).to raise_error(Errno::ECONNREFUSED)
       server.start
       expect(player).not_to raise_error(Errno::ECONNREFUSED)
   end
end