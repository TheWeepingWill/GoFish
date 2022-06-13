require_relative 'card_deck'
require_relative 'gofish_player'
require 'pry'
class GoFishGame
    STARTING_HAND_COUNT = 7
    attr_reader :players
    attr_accessor :deck

    def initialize(players_names)
      @players = {}
      players_names.each do |player_name|
          players.merge!({ player_name => GoFishPlayer.new(player_name) })
      end
              
      @deck = CardDeck.new
    end

    def start 
        deck.shuffle
        deal_cards
    end

    def deal_cards
        STARTING_HAND_COUNT.times { players.each_value { |player| player.take_cards([deck.deal]) } }
    end

    def play_round(requesting_player, requested_cards, targeted_player)
        if players.fetch(targeted_player).give_cards(requested_cards) == []
           go_fish(players.fetch(requesting_player))
        end
    end

    def starting_player
         players.sample 
    end

    def go_fish(player)
       player.take_cards(deck.deal)
    end

    def names
        players.keys
    end
    def object
        players.values
    end
end