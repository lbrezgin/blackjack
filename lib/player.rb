class Player
  
  attr_accessor :name, :cards, :score, :deck
  def initialize(name, deck)
    @name = name
    @deck = deck
    @score ||=0
    @cards = []
  end

  def take_card
    cards << deck.pop_card if cards.size < 3
    calculate_score
  end

  private
  
  def calculate_score
    score = 0
    aces_count = 0

    cards.each do |card|
      if card[1] == "0"
        score += deck.cards["10"]
      elsif card[0] == "A"
        score += 11
        aces_count += 1
      else
        score += deck.cards[card[0]]
      end
    end

    while score > 21 && aces_count > 0
      score -= 10
      aces_count -= 1
    end

    self.score = score
  end
end
