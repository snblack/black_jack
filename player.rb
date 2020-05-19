# frozen_string_literal: true

class Player
  attr_accessor :account, :cards
  attr_reader :name

  def initialize(name)
    @name = name
    @account = 100
    @cards = []
  end
  
# rubocop:disable Metrics/MethodLength, Layout/CommentIndentation
  def current_score
    @score = 0
    aces = []
    @cards.each do |card|
      if card.value == 'A'
        aces << card
      else
        @score += card.count_score_card
      end
    end
    aces.each do |_tuz|
      if @score + 11 <= 21
        @score += 11
      elsif @score + 11 > 21
        @score += 1
      end
    end
    @score
  end
# rubocop:enable Metrics/MethodLength, Layout/CommentIndentation

  def credit_winnings(rate)
    @account += rate
  end

  def credit_draw(rate)
    @account += rate / 2
  end
end
