module Game 
  def start_game(player)
    give_random_cards(player)
    player.place_a_bet
    show_status(player)
  end
end
