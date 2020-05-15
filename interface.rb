class Interface
  def start
    puts 'Привет. Я дилер игры Black Jack'
    puts 'Как тебя зовут?'
    name = gets.chomp
    @user = User.new(name)
    @dealer = Dealer.new
    puts "\n----------"
    puts "Привет, #{@user.name}!"
    puts "Ваш баланс #{@user.account}$"
    new_game
  end

  def new_game
    deck = Deck.new
    deck.start(@user, @dealer)
    puts 'У вас на руках карты:'
    @user.cards.each { |card| puts "#{card.value + card.suit}"}
    puts "У вас #{@user.current_score} очков"
    puts "\n----------"
    puts "У дилера тоже две карты\n*\n*"
    puts "Баланс дилера #{@dealer.account}$"
  end


end
