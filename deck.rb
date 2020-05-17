class Deck
  attr_reader :values

  VALUES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => @ace}
  SUITS = ['♦', '♠', '♥ ', '♣']

  def initialize
    @ace = [10, 1]
  end

  def start(user, dealer)
     user.cards << random_card_from_deck
     user.cards << random_card_from_deck
     dealer.cards << random_card_from_deck
     dealer.cards << random_card_from_deck
  end

  def random_card_from_deck
    random_value = VALUES.keys.sample
    random_suit = SUITS.sample
    @card = Card.new(random_value,random_suit)
    @card
  end

end
