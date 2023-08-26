class Dealer 
  include Bank

  attr_accessor :cards, :score
  def initialize
    @name = "dealer"
    @bank = money
    @cards = []
    @score = 0
  end
end
