class Dealer
  attr_accessor :account, :cards
  attr_reader :name

  def initialize
    @account = 100
    @name = 'Dealer'
    @cards = []
  end

end
