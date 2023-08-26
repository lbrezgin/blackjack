class User
  include Bank 

  attr_accessor :name, :cards, :score
  def initialize
    @name = "new user"
    @bank = money
    @cards = []
    @score = 0
  end
end
