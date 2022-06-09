require_relative '../lib/gofish_game'
require_relative '../lib/gofish_player'
require_relative '../lib/card'

describe '#GoFishGame' do 
    let (:player1) { GoFishPlayer.new('Vessimir')}
    let (:player2) { GoFishPlayer.new('London')}
    let (:player3) { GoFishPlayer.new('Zig')}
    let (:card1) { Card.new('King', 'Hearts') }
    let (:card2) { Card.new('King', 'Diamonds') }
    let (:card3) { Card.new('Queen', 'Spades') }
    let (:game) { GoFishGame.new([player1, player2, player3]) }

    it 'initializes with players' do
        expect { GoFishGame.new }.to raise_error(ArgumentError) 
        expect { game }.not_to raise_error
    end

    describe '#Start' do 

        it 'deals cards to all the players' do 
           game.start
           expect(player1.hand_count).to eq 7
        end

    end

    describe 'play_round' do 

       it 'requesting player does not get card if targeted player does not have rank' do 
        player2.take_cards([card1])
        game.play_round(player1, 'Threes', player2)
        expect(player2.hand).to eq [card1]
        expect(player1.hand_count).to eq 1
       end
    end


end