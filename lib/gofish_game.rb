require_relative 'card_deck'
require_relative 'gofish_player'
require 'pry'
class GoFishGame
    attr_reader :players
    attr_accessor :deck

    def initialize(players)
        @players = players
        @deck = CardDeck.new
    end

    def start 
        deck.shuffle
        deal_cards
    end

    def deal_cards
        7.times do players.each do |player|
           player.take_cards([deck.deal])
           end
        end
    end

    def play_round(active_player, requested_cards, targeted_player)
        if targeted_player.give_cards(requested_cards) == []
           go_fish(active_player)
        end
    end

    def choose_starting_player
         players.sample 
    end

    def go_fish(player)
       player.take_cards(deck.deal)
    end
end