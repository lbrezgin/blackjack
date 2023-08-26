require_relative 'lib/game.rb'
require_relative 'lib/bank.rb'
require_relative 'lib/dealer.rb'
require_relative 'lib/user.rb'
require_relative 'lib/deck.rb'

class Main 
  include Game
  attr_reader :dealer, :deck
  attr_accessor :user
  def initialize
    @dealer = Dealer.new
    @user = User.new
    @deck = Deck.new
  end

  def start 
    welcome_inscription
    greetings
    start_game(user)
    start_game(dealer)
  end

  private

  def check_score(cards)
    score = 0
    cards.each do |card|
      score += deck.cards[card[0]]
    end
    score
  end

  def show_status(player)
    if player.is_a?(User)
      puts "У вас #{player.cards} - это #{player.score} очков"
    else 
      puts "Количество карт у дилера:  #{player.cards.count}"
    end
  end

  def give_random_cards(player)
    player.cards = deck.deck_arr.sample(2)
    delete_cards_in_deck(player.cards, deck.deck_arr)
    player.score = check_score(player.cards)
  end

  def delete_cards_in_deck(player, d) 
    player.each { |card| d.delete(card) }
  end

  def greetings
    puts "Добро пожаловать!"
    print "Представьтесь пожалуйста: "
    name = gets.chomp
    self.user.name = name
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
