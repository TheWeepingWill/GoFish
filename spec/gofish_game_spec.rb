require_relative '../lib/gofish_game'
require_relative '../lib/gofish_player'
require_relative '../lib/card'
require 'pry'

describe '#GoFishGame' do 
    let (:player1) { GoFishPlayer.new('Vessimir') }
    let (:player2) { GoFishPlayer.new('London') }
    let (:player3) { GoFishPlayer.new('Zig') }
    let (:card1) { Card.new('King', 'Hearts') }
    let (:card2) { Card.new('King', 'Diamonds') }
    let (:card3) { Card.new('Queen', 'Spades') }
    let (:card4) { Card.new('King', 'Clubs') }
    let (:card5) { Card.new('King', 'Hearts') }
    let (:game) { GoFishGame.new([player1, player2, player3]) }

    it 'initializes with players'do
        expect { GoFishGame.new }.to raise_error(ArgumentError) 
        expect { game }.not_to raise_error
    end

    describe '#deal_cards' do 
        it 'deals out a standard deck' do 
            cards_dealt_count = game.players.count * 7
            game.start
            expect(player1.hand_count).to eq 7
            expect(player2.hand_count).to eq 7
            expect(player3.hand_count).to eq 7
            expect(game.deck.card_count).to eq CardDeck::STANDARD_DECK_LENGTH - cards_dealt_count
        end
    end 

    describe '#Start' do 

        it 'deals cards to all the players' do 
           cards_dealt_count = game.players.count * 7
           game.start
           expect(player1.hand_count).to eq 7
           expect(player2.hand_count).to eq 7
           expect(player3.hand_count).to eq 7
           expect(game.deck.card_count).to eq CardDeck::STANDARD_DECK_LENGTH - cards_dealt_count
           expect(game.current_player).to eq player1
        end

    end

    describe 'play_round' do 

       it 'does not get card from player or fishing' do 
        player2.take_cards([card3])
        player1.take_cards([card1])
        game.play_round(player1.name, 'King', player2.name)
        expect(player2.hand).to eq [card3]
        expect(player1.hand_count).to eq 2
        expect(game.current_player).to eq player2
       end

       it 'does not get card from player but gets a match from fishing' do 
        game1 = rigged_game(players: [player1, player2], card_deck: CardDeck.new([card1]))
        player1.take_cards(card2)
        player2.take_cards(card3)
        game1.play_round(player1.name, 'King', player2.name)
        expect(player2.hand_count).to eq 1
        expect(player1.hand_count).to eq 2
        expect(game1.deck.card_count).to eq 0 
        expect(game1.current_player).to eq player1
       end

       it 'gets a match from a player' do 
        game2 = rigged_game(players: [player1, player2])
        player1.take_cards(card1)
        player2.take_cards(card2)
        game2.if_hand_empty
        game2.play_round(player1.name, 'King', player2.name)
        expect(player2.hand_count).to eq 0 
        expect(player1.hand_count).to eq 2
        expect(player1.hand).to eq [card1, card2]
        expect(game2.deck).to eq []
        expect(game2.current_player).to eq player1       
      end

      it 'plays a round as long as a player has  card' do 
        game3 = rigged_game(players: [player1, player2], card_deck: CardDeck.new([card1]))
        player2.take_cards(card2)
        expect(game3.play_round(player1.name, 'King', player2.name)).to eq 'You do not have this card' 
        game3.if_hand_empty
        game3.play_round(player1.name, 'King', player2.name)
        expect(player1.hand).to eq [card1, card2]
        expect(game3.deck.cards).to eq []
      end


      it 'knows if a book has been completed', :focus do 
        game4 = rigged_game(players: [player1, player2], card_deck: CardDeck.new([card1]))
        player2.take_cards(card3)
        player1.take_cards(card2, card4, card5)
        game4.play_round(player1.name, 'King', player2.name)
        expect(player1.hand).to eq []
        expect(game4.completed_books).to eq 1 
      end
    end

    def rigged_game(players: [], card_deck: [])
        GoFishGame.new(players, card_deck)
    end

    describe 'if_hand_empty' do 
        it 'lets a player draw if their hand is empty' do 
            game5 = rigged_game(players: [player1, player2], card_deck: CardDeck.new([card1]))
            player2.take_cards(card2)
            expect(player1.hand).to eq []
            game5.if_hand_empty
            expect(game5.deck.cards).to eq []
            expect(player1.hand_count).to eq 1
        end
    
        it 'skips a player if they do not have a card and the deck is empty' do 
            game6 = rigged_game(players: [player1, player2])
            expect(game6.current_player).to eq player1
            game6.if_hand_empty
            expect(game6.current_player).to eq player2
        end
    end
end