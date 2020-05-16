class Interface
  def start
    cls
    puts 'Привет. Я дилер игры Black Jack'
    puts 'Как тебя зовут?'
    name = gets.chomp
    @user = User.new(name)
    @dealer = Dealer.new
    cls
    puts "Привет, #{@user.name}!
Игра начинается!\n\n"
    puts "Ваш баланс #{@user.account}$"
    puts "Ставка в каждой игре 10$\n\n"
    puts "Начнем?"
    puts "1 - Да"
    input = gets.chomp.to_i
    cls
    if input == 1
      new_game
    else
      abord
    end
  end

  def new_game
    cls
    @deck = Deck.new
    @deck.start(@user, @dealer)
    rate
  end

  def current_situation_user
    puts "У вас на руках #{@user.cards.count} карты:"
    @user.cards.each { |card| puts "#{card.value + card.suit}"}
    puts "У вас #{@user.current_score} очков"
    puts "\n----------"
  end

  def current_situation_dealer
    puts "У дилера #{@dealer.cards.count} карты"
    # puts "Баланс дилера #{@dealer.account}$"
  end

  def rate
    @rate = Rate.new
    @user.account -= 10
    @dealer.account -= 10
    puts "Ваша ставка #{@rate.bid/2}$\n\n"
    current_situation_user
    user_move
  end

  def user_move
    puts "\nКакой ваш ход, #{@user.name}?"
    puts '1 - Пропустить'
    puts '2 - Добавить карту'
    puts '3 - Открыть карты'
    input = gets.chomp.to_i
    case input
    when 1
      skip_move
    when 2
      add_card
    when 3
      open_cards
    end
  end

  def skip_move
    cls
    puts "Подождите, пока походит дилер"
    sleep 5
    dealer_move
  end

  def add_card
    @user.cards << @deck.random_card_from_deck
    cls
    current_situation_user
    puts "Подождите, пока походит дилер"
    sleep 7
    dealer_move
  end

  def open_cards
    cls
    result
  end

  def result
    puts "\n*** Результат игры ***"
    puts "\nВаши очки: #{@user.current_score}"
    @user.cards.each { |card| puts "#{card.value + card.suit}"}

    puts "\nОчки дилера: #{@dealer.current_score}"
    @dealer.cards.each { |card| puts "#{card.value + card.suit}"}

    puts "\n\n"

    if @user.current_score > 21
      puts 'Вы проиграли. У вас перебор.'
      win_dealer
    elsif @dealer.current_score > 21
      puts 'Ура! Вы победили! У дилера перебор.'
      win_user
    elsif @user.current_score == @dealer.current_score
      puts 'Ничья'
      draw
    elsif @dealer.current_score > @user.current_score
      puts "Дилер победил!"
      win_dealer
    else
      puts "Ура! Вы победили!"
      win_user
    end

    puts "Ваш баланс: #{@user.account}$"

    puts "\n-----------------"
    puts "\nСыграть еще раз?"
    puts '1 - Да'
    puts '2 - Нет'

    input = gets.chomp.to_i
    if input == 1
      @user.cards = []
      @dealer.cards = []
      if @user.account >= 10 && @dealer.account >= 10
        new_game
      else
        puts 'У одного из игроков недостаточно денег для игры!'
      end
    else
      abord
    end
  end

  def dealer_move
    cls
    if @dealer.current_score <= 17
       @dealer.cards << @deck.random_card_from_deck
       puts "Дилер взял еще одну карту"
       puts "У дилера #{@dealer.cards.count} карты"
    else
      puts "Дилер пропустил ход"
    end
    result

  end

  private

  def cls
  system('cls') || system('clear')
  end

  def win_user
    @user.credit_winnings(@rate.bid)
  end

  def win_dealer
    @dealer.credit_winnings(@rate.bid)
  end

  def draw
    @dealer.credit_draw(@rate.bid)
    @user.credit_draw(@rate.bid)
  end

end
