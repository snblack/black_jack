class Interface
  def start
    puts 'Привет. Я дилер игры Black Jack'
    puts 'Как тебя зовут?'
    name = gets.chomp
    @user = User.new(name)
    @dealer = Dealer.new
    cls
    puts "Привет, #{@user.name}!"
    new_game
  end

  def new_game
    @deck = Deck.new
    @deck.start(@user, @dealer)
    rate
  end

  def current_situation_user
    puts "Ваш баланс #{@user.account}$"
    puts "У вас на руках #{@user.cards.count} карты:"
    @user.cards.each { |card| puts "#{card.value + card.suit}"}
    puts "У вас #{@user.current_score} очков"
    puts "\n----------"
  end

  def current_situation_dealer
    puts "У дилера #{@dealer.cards.count} карты\n*\n*"
    puts "Баланс дилера #{@dealer.account}$"
  end

  def rate
    @rate = Rate.new
    @user.account -= 10
    @dealer.account -= 10
    puts "Ставка #{@rate.bid}$"
    current_situation_user
    user_move
  end

  def user_move
    puts "\nВаш ход #{@user.name}"
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
    dealer_move
  end

  def add_card
    @user.cards << @deck.random_card_from_deck
    current_situation_user
    dealer_move
  end

  def open_cards
    puts "Вкрываем карты"
    puts "У вас #{@user.current_score} очков"
    puts "Карты дилера: "
    puts "У дилера на руках #{@dealer.cards.count} карты:"
    @dealer.cards.each { |card| puts "#{card.value + card.suit}"}
    puts "У дилера #{@dealer.current_score} очков "
    result
  end

  def result
    if @user.current_score == @dealer.current_score
      puts 'Ничья'
      @dealer.credit_draw
      @user.credit_draw
    elsif @user.current_score > 21 && @dealer.current_score > 21
      puts 'И у дилера перебор и у вас перебор. Ничья'
      @dealer.credit_draw(@rate.bid)
      @user.credit_draw(@rate.bid)
    elsif @user.current_score > 21
      puts 'У вас перебор. Вы проиграли'
      @dealer.credit_winnings(@rate.bid)
    elsif @dealer.current_score > 21
      puts 'Вы выиграли у дилера перебор'
      @user.credit_winnings(@rate.bid)
    elsif @dealer.current_score > @user.current_score
      puts "Дилер победил"
      @dealer.credit_winnings(@rate.bid)
    else
      puts "Ура! Вы победили!"
      @user.credit_winnings(@rate.bid)
    end
    current_situation_user
    current_situation_dealer
  end

  def dealer_move
    if @dealer.current_score >= 17
      current_situation_dealer
      user_move
    else
       @dealer.cards << @deck.random_card_from_deck
    end
    current_situation_dealer
    user_move
  end

  private

  def cls
  system('cls') || system('clear')
  end

end
