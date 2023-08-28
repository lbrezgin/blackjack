class Player
  
  attr_accessor :name, :cards, :score, :deck
  def initialize(name, deck)
    @name = name
    @deck = deck
    @score = 0
    @cards = []
  end

  def add_a_card(num)
    num.times { cards << deck.deck_arr.sample }
    cards.each { |card| deck.deck_arr.delete(card) }
    calculate_score
  end

  private
  def calculate_score 
    score = 0
    cards.each do |card|
      if card[1] == "0"
        score += deck.cards["10"]
      elsif (card[0] == "A") && (score + 11) <= 21
        score += 11
      else
        score += deck.cards[card[0]]
      end
    end
    self.score = score
  end
end
