require_relative 'card'
class CardDeck
     attr_accessor :cards
    def initialize(cards = standard_deck)
        @cards = cards

    end

    def standard_deck 
        deck = []
        Card::RANKS.each do |rank|
          Card::SUITS.each do |suit|
          deck.push(rank + ' of ' + suit)
          end
        end
        deck 
    end

    def deal 
        cards.shift
    end

    def shuffle
       cards.shuffle!
    end
    
end