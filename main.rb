require_relative 'lib/player.rb'
require_relative 'lib/deck.rb'

class Main 
  ACTIONS = [
    { id: '1', title: 'Пропустить ход', action: :skip },
    { id: '2', title: 'Добавить карту', action: :add_card },
    { id: '3', title: 'Открыть карты', action: :show_cards }
  ]

  attr_reader :deck, :user, :dealer, :name
  attr_accessor :status, :user_bank, :dealer_bank

  def initialize
    @user_bank = 100
    @dealer_bank = 100
    @player_skipped = false
    @dealer_skipped = false
  end

  def start  
    welcome_inscription
    greetings 
    loop do 
      game
      if user_bank == 0
        puts "У вас кончились деньги!"
        break
      elsif dealer_bank == 0
        puts "У диллера закончились деньги!"
        break
      end
    end
  end
  
  def game 
    get_players_ready
    puts "Делаем ставки!"
    puts "У вас в банке осталось #{user_bank} $"
    puts "У дилера в банке осталось #{dealer_bank} $"
    loop do
      show_status
      show_actions 
      choice = gets_choice
      break if call_action(choice) == false
      
      if (dealer.score < 17) && (dealer.cards.size < 3)
        dealer.take_card
        puts "Дилер взял карту!" 
      elsif dealer.score >= 17 
        puts "Дилер пропустил ход!"
        @dealer_skipped = true
      end

      if (user.cards.size == 3) && (dealer.cards.size == 3) || (@dealer_skipped && @player_skipped) == true
        show_cards 
        break
      end
    end
  end

  private 

  def get_players_ready 
    @deck = Deck.new
    @user = Player.new(self.name, deck)
    @dealer = Player.new("dealer", deck)
    self.user_bank -= 10
    self.dealer_bank -= 10
    2.times do 
      user.take_card
      dealer.take_card
    end
  end

  def show_status 
    puts "У вас #{user.cards} - это #{user.score} очков!"
    puts "У дилера: " 
    dealer.cards.each { |card| puts " * " }
  end

  def call_action(choice)
    if choice
      send(choice)
      return false if choice == :show_cards 
    end
  end

  def gets_choice
    input = gets.chomp
    hash_of_action = ACTIONS.find { |action| action[:id] == input }
    if hash_of_action
      hash_of_action[:action]
    else
      puts 'Действие не найдено'
    end
  end

  def skip 
    puts "Ход пропущен!"
    @player_skipped = true
  end

  def add_card 
    if user.take_card 
      puts "Вы взяли карту #{user.cards.last}"
    else
      puts "Вы не можете брать больше 3 карт!"
    end
  end

  def show_cards 
    puts "Вы набрали #{user.score}, у дилера #{dealer.score}"
    if (user.score == dealer.score) || (user.score > 21 && dealer.score > 21)
      puts "У вас ничья!"
      self.user_bank += 10
      self.dealer_bank += 10
    elsif (user.score > 21) && (dealer.score <= 21)
      puts "Диллер выиграл!"
      self.dealer_bank += 20
    elsif (user.score <= 21) && (dealer.score > 21)
      puts "Вы победили!"
      self.user_bank += 20
    elsif (user.score <= 21) && (dealer.score <= 21)
      if (21 - user.score) < (21 - dealer.score)
        puts "Вы победили!"
        self.user_bank += 20
      else
        puts "Диллер выиграл!"
        self.dealer_bank += 20
      end
    end
    puts "У дилера были #{dealer.cards}"
    puts "---------------------------"
  end

  def show_actions 
    puts "Вы можете: " 
    puts "Пропустить ход - 1" 
    puts "Добавить карту - 2" if user.cards.size < 3
    puts "Открыть все карты - 3" 
  end

  def greetings
    puts "Добро пожаловать!"
    print "Представьтесь пожалуйста: "
    @name = gets.chomp
    puts "Здравствуйте #{name}, ну что же, давайте начнем!"
  end

  def welcome_inscription
    puts "
    ██████╗░██╗░░░░░░█████╗░░█████╗░██╗░░██╗░░░░░██╗░█████╗░░█████╗░██╗░░██╗
    ██╔══██╗██║░░░░░██╔══██╗██╔══██╗██║░██╔╝░░░░░██║██╔══██╗██╔══██╗██║░██╔╝
    ██████╦╝██║░░░░░███████║██║░░╚═╝█████═╝░░░░░░██║███████║██║░░╚═╝█████═╝░
    ██╔══██╗██║░░░░░██╔══██║██║░░██╗██╔═██╗░██╗░░██║██╔══██║██║░░██╗██╔═██╗░
    ██████╦╝███████╗██║░░██║╚█████╔╝██║░╚██╗╚█████╔╝██║░░██║╚█████╔╝██║░╚██╗
    ╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝"
  end
end

Main.new.start




