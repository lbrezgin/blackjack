class Deck 
  attr_reader :deck
  
  def initialize
    @cards = {
      "A" => 1,
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7, 
      "8" => 8, 
      "9" => 9,
      "10" => 10,
      "J" => 10,
      "Q" => 10,
      "K" => 10
    }
  
    @suits = ["+", "<3", "^", "<>"]
    @deck = []
  end

  def make_a_deck
    @cards.each_key do |key|
      @suits.each do |suit|
        @deck.push("#{key}#{suit}")
      end
    end
    @deck
  end
end

