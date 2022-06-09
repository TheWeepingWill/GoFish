require_relative '../lib/gofish_server'

describe '#GoFishServer' do 
    let (:server) { GoFishServer.new }
    
    it 'starts' do 
       expect { server.start }.not_to raise_error

    end
end