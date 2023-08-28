class Deck 
  attr_reader :deck_arr, :cards
  
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
    @deck_arr = []
  end

  def pop_card
    shuffle_deck if deck_arr.empty?
    deck_arr.pop
  end

  private

  def shuffle_deck
    @deck_arr = @cards.keys.flat_map { |key| @suits.map { |suit| "#{key}#{suit}" } }.shuffle
  end
end
