class Deck
  attr_reader :values

  def initialize
    @tuz = [10, 1]
    @values = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => @tuz}
    @suits = ['♦', '♠', '♥ ', '♣']
  end

  def start(user, dealer)
     user.cards << random_card_from_deck
     user.cards << random_card_from_deck
     dealer.cards << random_card_from_deck
     dealer.cards << random_card_from_deck
  end

  def random_card_from_deck
    random_value = @values.keys.sample
    random_suit = @suits.sample
    @card = Card.new(random_value,random_suit)
    @card
  end

end
