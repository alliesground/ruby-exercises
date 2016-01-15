# 1. Initialize card deck.
# 2. Deal two cards each to player and dealer.
# 3. Ask player for hit or stay.
# 4. If hit, deal another card to the player, until player wants to stay or is busted.
# 7. Dealer(computer) turn.
# 8. Dealer has to hit until card total >= 17 after which it can decide to stay.
# 9. If total > 21 dealer busted, player wins.
# 10. Compare card totals of player and dealer.
# 11.   - If player has highest value player wins.
# 12.   - If dealer has highest value dealer wins.

require 'pry'

SUITS = ['H', 'D', 'C', 'S']
VALUES = ['2', '3', '4', '5', '6', '7',
          '8', '9', '10', 'jack', 'queen', 'king', 'ace']

def prompt(message)
  puts "=> #{message}"
end

def initialize_card_deck
  SUITS.product(VALUES).shuffle
end

def initialize_deal(player_cards, dealer_cards, deck)
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
end

def player_turn(cards, card_deck, viewable_dealer_card)
  prompt "Player turn"
  loop do
    display(cards)
    prompt "One of Dealer's cards : #{viewable_dealer_card}"
    prompt "Would you like to HIT or STAY (Type 'h' for hit | 's' for stay)"
    choice = ''
    loop do
      choice = gets.chomp.downcase
      break if ['h', 's'].include?(choice)
      prompt "Press 'h' for HIT | Press 's' for STAY"
    end

    deal!(cards, card_deck) if choice == 'h'

    break if choice == 's' || busted?(cards)
  end
end

def dealer_turn(cards, card_deck)
  prompt "Dealer turn"
  while total_points(cards) <= 17
    display(cards)
    prompt "Press 'h' to hit"
    choice = gets.chomp
    deal!(cards, card_deck) if choice == 'h'
    break if busted?(cards)
  end

  unless busted?(cards)
    loop do
      display(cards)
      prompt "Do you want to HIT or STAY (Type 'h' for hit | 's' for stay)"
      choice = gets.chomp
      deal!(cards, card_deck) if choice == 'h'
      break if choice == 's' || busted?(cards)
    end
  end
end

def deal!(cards, card_deck)
  cards.push(card_deck.pop)
end

def busted?(cards)
  total_points(cards) > 21
end

def total_points(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == 'ace'
      sum += 11
    elsif value.to_i == 0 # jack, queen, heart
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.count('ace').times do
    sum -= 10 if sum > 21
  end

  sum
end

def display(user_cards)
  cards = user_cards.map { |card| card[1] }
  prompt "Your cards : #{cards.join(', ')}"
end

def detect_winner(p_cards, d_cards)
  player_total = total_points(p_cards)
  dealer_total = total_points(d_cards)

  if player_total > dealer_total
    return 'Player'
  elsif dealer_total > player_total
    return 'Dealer'
  end
end

def someone_won?(p_cards, d_cards)
  !!detect_winner(p_cards, d_cards)
end

def play_again?
  prompt "Do you want to play again? ('y' for yes)"
  return true if gets.chomp.downcase.start_with?('y')

  false
end

def display_final_result(p_cards, d_cards)
  player_card_values = p_cards.map { |card| card[1] }
  dealer_card_values = d_cards.map { |card| card[1] }

  player_card_total = total_points(p_cards)
  dealer_card_total = total_points(d_cards)

  puts ""
  puts "------------"
  puts "Final Result"
  puts "------------"
  puts ""
  prompt "Player cards: #{player_card_values.join(', ')}"
  prompt "Total: #{player_card_total}"
  puts ""
  prompt "Dealer cards: #{dealer_card_values.join(', ')}"
  prompt "Total: #{dealer_card_total}"
  puts ""

  nil
end

# Start
loop do
  card_deck = initialize_card_deck
  player_cards = []
  dealer_cards = []

  initialize_deal(player_cards, dealer_cards, card_deck)
  viewable_dealer_card = dealer_cards.sample[1]

  player_turn(player_cards, card_deck, viewable_dealer_card)

  if busted?(player_cards)
    display(player_cards)
    prompt "Sorry you are busted! Dealer Wins!"
    display_final_result(player_cards, dealer_cards)
    next if play_again?
    break
  end

  dealer_turn(dealer_cards, card_deck)

  if busted?(dealer_cards)
    display(dealer_cards)
    prompt "Sorry you are busted! Player Wins!"
    display_final_result(player_cards, dealer_cards)
    next if play_again?
    break
  end

  if someone_won?(player_cards, dealer_cards)
    prompt "#{detect_winner(player_cards, dealer_cards)} Won!"
  else
    prompt "It's a tie"
  end
  display_final_result(player_cards, dealer_cards)

  break unless play_again?
end

prompt "Thank you for your time, Good Bye"
