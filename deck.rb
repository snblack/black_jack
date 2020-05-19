# frozen_string_literal: true

class Deck
  attr_reader :values, :cards

  VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
             '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10,
             'A' => @ace }.freeze
  SUITS = ['♦', '♠', '♥ ', '♣'].freeze

  def initialize
    @ace = [10, 1]
    @cards = []

    VALUES.keys.each do |value|
      @cards << Card.new(value, SUITS[0])
      @cards << Card.new(value, SUITS[1])
      @cards << Card.new(value, SUITS[2])
      @cards << Card.new(value, SUITS[3])
    end
  end

  def shuffle
    @cards = @cards.sort_by { rand }
  end

  def give_cards(player, number)
    while number.positive?
      player.cards << @cards[0]
      @cards.shift
      number -= 1
    end
  end
end
