require 'pry'
class GoFishPlayer
    attr_reader :name
    attr_accessor :hand
    def initialize(name)
       @name = name 
       @hand = []
    end

   def take_cards(*cards)
    [cards].flatten.each do |card|
        hand.push(card)
    end
   end
   
   def give_cards(rank)
    cards =  hand.select {|card| card.rank == rank}
    hand.delete_if {|card| card.rank == rank}
    cards
   end
   
   def has_cards?(rank) 
    hand.any? {|card| card.rank == rank} 
   end

   def hand_count
    hand.count 
   end


 end