require_relative 'card_deck'
require_relative 'gofish_player'
require 'pry'
class GoFishGame
    STARTING_HAND_COUNT = 7
    attr_reader :players, :starter
    attr_accessor :deck, :player_turn, :rounds

    def initialize(players, deck = CardDeck.new)
      @players = players
      @rounds = 0         
      @deck = deck
    end

    def start 
        deck.shuffle
        deal_cards
    end

    def deal_cards
            STARTING_HAND_COUNT.times { players.each { |player| player.take_cards([deck.deal]) } }
    end

    def play_round(requesting_player, requested_rank, targeted_player)
        return 'You do not have this card' if !validation(requesting_player, requested_rank)
        taken_cards = get_player(targeted_player).give_cards(requested_rank) 
        if taken_cards.count == 0 
           go_fish_card = go_fish(get_player(requesting_player))
          if go_fish_card.rank != requested_rank
            @rounds += 1
          end
        else
            get_player(requesting_player).take_cards(taken_cards)
        end
        taken_cards
    end

    def get_player(name)
        players.find { |p| p.name == name }
    end

    def go_fish(player)
       deck == [] ? nil : player.take_cards(deck.deal)[0]
    end

    def names
        players.map { |player| player.name }
    end

    def  over?
       completed_books == 13
    end

    def  current_player  
        players[rounds]
    end

    def deck_count
        deck.card_count
    end
    
    def if_hand_empty
        if current_player.hand.empty?
             card = go_fish(current_player)
             if card == nil
                @rounds += 1
             end
        end
    end

    def validation(player_name, card_rank)
     ranks = get_player(player_name).hand.map { |card| card.rank}
     ranks.any?(card_rank)
    #  binding.pry
    end

    def completed_books
        players.sum { |player| player.books.count }
    end
end