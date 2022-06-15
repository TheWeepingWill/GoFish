require 'pry'
require_relative 'card_deck'
require_relative 'gofish_player'
class GoFishPlayer
    attr_reader :name
    attr_accessor :hand, :books 
    def initialize(name)
       @name = name 
       @hand = []
       @books = []
    end

   def take_cards(*cards)
    [cards].flatten.each do |card|
        hand.push(card)
    end
    book_creator
    cards
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
   
   def hand_ranks
     hand.map { |card| card.rank}
   end

   def book_creator 
       Card::RANKS.each do |rank|
        possible_book =  hand_ranks.take_while {|hand_rank| hand_rank == rank}
        if possible_book.count == 4
            books.push("#{rank}s")
            hand.delete_if {|card| card.rank == rank}
        end
    end
   end

 end