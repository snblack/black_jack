# frozen_string_literal: true

require './interface.rb'
require './player.rb'
require './dealer.rb'
require './deck.rb'
require './card.rb'
require './rate.rb'
require './game.rb'
require './black_jack.rb'

interface = Interface.new
interface.start

game = Game.new(interface.player, interface)

interface.cls
interface.hello

# rubocop:disable Metrics/BlockLength

loop do
  if interface.input == 1
    game.new_game
    game.do_rate
    interface.cls
    interface.rate_status(game.rate)
    interface.player_move
  else
    abord
  end

  interface.cls

  case interface.input

  when 1
    interface.skip_move
    interface.cls
    if game.dealer.current_score <= 17
      game.deck.give_cards(game.dealer, 1)
      interface.dealer_move(game.dealer)
    else
      interface.dealer_skip
    end

  when 2
    game.deck.give_cards(game.player, 1)
    interface.cls
    interface.current_situation_player
    interface.add_card
    interface.cls
    game.deck.give_cards(game.dealer, 1)
    interface.dealer_move(game.dealer)

  when 3
    interface.cls
  end

  interface.result(game.player, game.dealer)
  game.result
  interface.balance

  break if interface.input == 2

  next unless interface.input == 1

  game.player.cards = []
  game.dealer.cards = []
  if game.player.account <= 10 && game.dealer.account <= 10
    interface.not_enough_money
  end
end

# rubocop:enable Metrics/BlockLength
