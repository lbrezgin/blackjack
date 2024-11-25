require_relative 'lib/player.rb'
require_relative 'lib/deck.rb'

class Main 
  ACTIONS = [
    { id: '1', title: 'Skip a turn', action: :skip },
    { id: '2', title: 'Add a card', action: :add_card },
    { id: '3', title: 'Open all cards', action: :show_cards }
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
        puts "You've run out of money!"
        break
      elsif dealer_bank == 0
        puts "The dealer ran out of money!"
        break
      end
    end
  end
  
  def game 
    get_players_ready
    puts "Place bets!"
    puts "In your bank are #{user_bank} $"
    puts "In dealers bank are #{dealer_bank} $"
    loop do
      show_status
      show_actions 
      choice = gets_choice
      break if call_action(choice) == false
      
      if (dealer.score < 17) && (dealer.cards.size < 3)
        dealer.take_card
        puts "Dealer take a card!"
      elsif dealer.score >= 17 
        puts "Dealer skip a turn!"
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
    puts "You have #{user.cards} - it is #{user.score} points!"
    puts "Dealer have: "
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
      puts 'Action do not find'
    end
  end

  def skip 
    puts "Turn was skipped!"
    @player_skipped = true
  end

  def add_card 
    if user.take_card 
      puts "You take a card #{user.cards.last}"
    else
      puts "You can not take more than 3 cards!"
    end
  end

  def show_cards 
    puts "Your score is #{user.score}, dealers score is #{dealer.score}"
    if (user.score == dealer.score) || (user.score > 21 && dealer.score > 21)
      puts "Draw!"
      self.user_bank += 10
      self.dealer_bank += 10
    elsif (user.score > 21) && (dealer.score <= 21)
      puts "Dealer win!"
      self.dealer_bank += 20
    elsif (user.score <= 21) && (dealer.score > 21)
      puts "You win!"
      self.user_bank += 20
    elsif (user.score <= 21) && (dealer.score <= 21)
      if (21 - user.score) < (21 - dealer.score)
        puts "You win!"
        self.user_bank += 20
      else
        puts "Dealer win!"
        self.dealer_bank += 20
      end
    end
    puts "Dealer had #{dealer.cards}"
    puts "---------------------------"
  end

  def show_actions 
    puts "You can: "
    puts "Skip a turn - 1"
    puts "Add a card - 2" if user.cards.size < 3
    puts "Open all cards - 3"
  end

  def greetings
    puts "Welcome!"
    print "Please, introduce yourself: "
    @name = gets.chomp
    puts "Hi #{name}, so, lets start!"
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
