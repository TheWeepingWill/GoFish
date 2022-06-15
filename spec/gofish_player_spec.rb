require_relative '../lib/gofish_player'
require_relative '../lib/card_deck'
require_relative '../lib/card'
require 'pry'

describe '#GoFishPlayer' do 
    let (:deck) { CardDeck.new }
    let (:player1) { GoFishPlayer.new('Vessimir')}
    let (:player2) { GoFishPlayer.new('London')}
    let (:card1) { Card.new('King', 'Hearts') }
    let (:card2) { Card.new('King', 'Diamonds') }
    let (:card3) { Card.new('King', 'Spades') }
    let (:card4) { Card.new('King', 'Clubs') }
    let (:card5) { Card.new('Queen', 'Spades') }

    it 'has a name' do 
        expect(player1.name).to eq 'Vessimir'
    end
       
    
    it 'takes cards' do 
        player1.take_cards([card1, card2])
        expect(player1.hand).to include(card1, card2)       
    end

    it 'gives cards' do
       player1.take_cards([card1, card2, card3]) 
       cards = player1.give_cards('King')
       expect(cards).to eq [card1, card2, card3]
       expect(player1.hand).to eq []
    end

    it 'returns true or false if a player has cards' do 
        player1.take_cards([card1, card2, card3])
        kings = player1.has_cards?('King')
        threes = player1.has_cards?('3')
        expect(kings).to eq true
        expect(threes).to eq false
    end

    it 'book creation' do 
        player1.take_cards(card1)
        expect(player1.books).to eq []
        player1.take_cards(card2)
        expect(player1.books).to eq []
        player1.take_cards(card3)
        expect(player1.books).to eq []
        player1.take_cards([card4])
        expect(player1.books).to eq ['Kings']
    end

end