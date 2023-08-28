require_relative 'lib/player.rb'
require_relative 'lib/deck.rb'

deck = Deck.new
user = Player.new("lev", deck)
dealer = Player.new("dealer", deck)

user.add_a_card(2)
p user.score 
p user
dealer.add_a_card(1)
p dealer.score
p dealer
