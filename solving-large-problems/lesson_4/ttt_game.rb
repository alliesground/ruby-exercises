# 1. Display the initial empty 3x3 board.
# 2. Ask the user to mark a square.
# 3. Computer marks a square.
# 4. Display the updated board state.
# 5. If winner, display winner.
# 6. If board is full, display tie.
# 7. If neither winner nor board is full, go to #2
# 8. Play again?
# 9. If yes, go to #1
# 10. If no, break loop and Good bye!

require 'pry'

def prompt(message)
  puts "=> #{message}"
end

def joinor(arr, options={})
  options = { delimiter: ', ', end_joinor: 'or' }.merge(options)
  last_char = arr.pop
  last_char = options[:end_joinor] + " #{last_char}"
  arr.push last_char
  arr.join(options[:delimiter])
end

PLAYERS = ['player', 'computer']
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def display_board(board)
  puts " "
  puts "     |     |     "
  puts "  #{board[1].nil? ? '1' : board[1]}  |  #{board[2].nil? ? '2' : board[2]}  |  #{board[3].nil? ? '3' : board[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[4].nil? ? '4' : board[4]}  |  #{board[5].nil? ? '5' : board[5]}  |  #{board[6].nil? ? '6' : board[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[7].nil? ? '7' : board[7]}  |  #{board[8].nil? ? '8' : board[8]}  |  #{board[9].nil? ? '9' : board[9]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts " "
end

def valid_choice?(choice, board)
  return true if board.keys.include? choice.to_i
  false
end

def selected?(choice, board)
  return false if board[choice.to_i].nil?
  true
end

def set_mark!(choice, board, mark)
  board.merge!(choice.to_i => mark)
end

def unmarked_squares_on(board)
  board.select { |_, v| v.nil? }.keys
end

def player_marks!(board)
  user_choice = ''
  loop do
    display_board(board)
    user_choice = gets.chomp

    if (valid_choice? user_choice, board) &&
       (!selected? user_choice, board)
      set_mark! user_choice, board, PLAYER_MARKER
      break
    elsif !valid_choice? user_choice, board
      prompt "Please choose an integer from 1 to 9"
    else
      prompt "This square has already been marked"
    end
  end
end

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def immediate_threat(line, board, marker)
  line_values = board.values_at(*line)

  if line_values.count(marker) == 2 &&
     line_values.include?(nil)
    return line.select { |val| board[val].nil? }.first
  end

  nil
end

def computer_marks!(board)
  computer_choice = nil

  # offensive first
  WINNING_LINES.each do |line|
    computer_choice = immediate_threat(line, board, COMPUTER_MARKER)
    break if computer_choice
  end

  # defensive
  if !computer_choice
    WINNING_LINES.each do |line|
      computer_choice = immediate_threat(line, board, PLAYER_MARKER)
      break if computer_choice
    end
  end

  if !computer_choice
    computer_choice = unmarked_squares_on(board).delete(5)
  end

  if !computer_choice
    computer_choice = unmarked_squares_on(board).sample
  end

  set_mark! computer_choice, board, COMPUTER_MARKER
end

def board_full?(board)
  unmarked_squares_on(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end

  nil
end

def initialize_board
  board = {}
  (1..9).each { |num| board.merge!(num => nil) }

  board
end

def play_again?
  user_choice = gets.chomp

  return true if user_choice.match(/^y/i)
end

def place_mark!(board, current_player)
  if current_player == 'player'
    player_marks!(board)
  else
    computer_marks!(board)
  end
end

def choose_player
  if gets.chomp.downcase.start_with?('y')
    PLAYERS.first
  else
    PLAYERS.last
  end
end

def alternate_player(current_player)
  PLAYERS.select {|val| val != current_player}.first
end

# START
loop do
  board = initialize_board
  prompt "Do you want to go first? (y/n)"
  current_player = choose_player
  
  loop do
    if current_player == 'player'
      prompt "Choose the square you would like to mark: #{joinor(unmarked_squares_on(board))}"
    end
    
    place_mark!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  if someone_won?(board)
    prompt "#{detect_winner(board)} Won!"
  else
    prompt "It's a tie"
  end

  display_board board

  prompt "Do you wish to play again ? (y for yes | n for no)"
  break unless play_again?
end

prompt "Thanks for playing, Good Bye"
