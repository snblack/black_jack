class User
  attr_accessor :account, :cards
  attr_reader :name

  def initialize(name)
    @name = name
    @account = 100
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

  def credit_winnings(rate)
    @account += rate
  end

  def credit_draw(rate)
    @account += rate/2
  end
end
