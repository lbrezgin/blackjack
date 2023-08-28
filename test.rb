require_relative 'lib/player.rb'
require_relative 'lib/deck.rb'

deck = Deck.new
user = Player.new("lev", deck)
dealer = Player.new("dealer", deck)

user.take_card
p user.score 
p user
dealer.take_card
p dealer.score
p dealer
