# frozen_string_literal: true

class Game
  attr_reader :player, :dealer, :interface, :deck, :rate
  def initialize(player, interface)
    @player = player
    @dealer = Dealer.new
    @interface = interface
    @deck = Deck.new
    @deck.shuffle
  end

  def new_game
    @deck.give_cards(@player, 2)
    @deck.give_cards(@dealer, 2)
  end

  def do_rate
    @rate = Rate.new
    @player.account -= 10
    @dealer.account -= 10
  end

  # rubocop:disable Metrics/MethodLength, Layout/CommentIndentation:
  def result
    if @player.current_score > 21
      win_dealer
    elsif @dealer.current_score > 21
      win_player
    elsif @player.current_score == @dealer.current_score
      draw
    elsif @dealer.current_score > @player.current_score
      win_dealer
    else
      win_player
    end
  end
# rubocop:enable Metrics/MethodLength, Layout/CommentIndentation:

  def win_player
    @interface.win_player
    @player.credit_winnings(@rate.bid)
  end

  def win_dealer
    @interface.win_dealer
    @dealer.credit_winnings(@rate.bid)
  end

  def draw
    @interface.win_dealer
    @dealer.credit_draw(@rate.bid)
    @player.credit_draw(@rate.bid)
  end
end
