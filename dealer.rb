class Dealer
  attr_accessor :account, :cards
  attr_reader :name

  def initialize
    @account = 100
    @name = 'Dealer'
    @cards = []
  end

  def current_score
    @score = 0
    tuzes = []
    @cards.each do |card|
      if card.value == 'A'
        tuzes << card
      else
        @score += card.count_score_card
      end
    end
      tuzes.each do |tuz|
      if @score + 11 <= 21
        @score += 11
      elsif @score + 11 > 21
        @score += 1
      end
    end
    @score
  end

end
