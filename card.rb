require "./deck.rb"

class Card < Deck

  attr_reader :value, :suit

  VALUES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => @ace}
  SUITS = ['♦', '♠', '♥ ', '♣']

  def initialize(value, suit)
    @value = value
    @suit = suit
    @ace = [10, 1]
  end

  def count_score_card
    VALUES[self.value]
  end

end
