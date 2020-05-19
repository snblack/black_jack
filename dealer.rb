# frozen_string_literal: true

class Dealer < Player
  attr_accessor :account, :cards
  attr_reader :name

  def initialize
    @account = 100
    @name = 'Dealer'
    @cards = []
  end
end
