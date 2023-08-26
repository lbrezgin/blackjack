module Bank
  def money 
    @money = 100
  end
  
  def place_a_bet
    @money -= 10
  end
end
