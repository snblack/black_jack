# frozen_string_literal: true

class Interface
  attr_reader :player, :input

  def start
    cls
    puts 'Привет. Я дилер игры Black Jack'
    puts 'Как тебя зовут?'
    name = gets.chomp
    @player = Player.new(name)
  end

  def hello
    puts "Привет, #{@player.name}!
Игра начинается!\n\n"
    puts "Ваш баланс #{@player.account}$"
    puts "Ставка в каждой игре 10$\n\n"
    puts 'Начнем?'
    puts '1 - Да'
    @input = gets.chomp.to_i
  end

  # rubocop:disable Lint/ParenthesesAsGroupedExpression, Layout/CommentIndentation
  def current_situation_player
    puts "У вас на руках #{@player.cards.count} карты:"
    @player.cards.each { |card| puts (card.value + card.suit).to_s }
    puts "У вас #{@player.current_score} очков"
    puts "\n----------"
  end
# rubocop:enable Lint/ParenthesesAsGroupedExpression, Layout/CommentIndentation

  def current_situation_dealer
    puts "У дилера #{@dealer.cards.count} карты"
  end

  def rate_status(rate)
    puts "Ваша ставка #{rate.bid / 2}$\n\n"
    current_situation_player
  end

  def player_move
    puts "\nКакой ваш ход, #{@player.name}?"
    puts '1 - Пропустить'
    puts '2 - Добавить карту'
    puts '3 - Открыть карты'
    @input = gets.chomp.to_i
  end

  def skip_move
    puts 'Подождите, пока походит дилер'
    sleep 2
  end

  def add_card
    puts 'Подождите, пока походит дилер'
    sleep 5
  end

  # rubocop:disable Metrics/AbcSize, Lint/ParenthesesAsGroupedExpression
  def result(player, dealer)
    puts "\n*** Результат игры ***"
    puts "\nВаши очки: #{@player.current_score}"
    player.cards.each { |card| puts (card.value + card.suit).to_s }

    puts "\nОчки дилера: #{dealer.current_score}"
    dealer.cards.each { |card| puts (card.value + card.suit).to_s }

    puts "\n\n"
  end
  # rubocop:enable Metrics/AbcSize, Lint/ParenthesesAsGroupedExpression

  def balance
    puts "Ваш баланс: #{@player.account}$"

    puts "\n-----------------"
    puts "\nСыграть еще раз?"
    puts '1 - Да'
    puts '2 - Нет'

    @input = gets.chomp.to_i
  end

  def dealer_move(dealer)
    puts 'Дилер взял еще одну карту'
    puts "У дилера #{dealer.cards.count} карты"
  end

  def dealer_skip
    puts 'Дилер пропустил ход'
  end

  def cls
    system('cls') || system('clear')
  end

  def not_enough_money
    puts 'У одного из игроков недостаточно денег для игры!'
  end

  def win_player
    puts 'Ура! Вы победили!'
  end

  def win_dealer
    puts 'Победил дилер'
  end

  def draw
    pute 'Ничья'
  end
end
