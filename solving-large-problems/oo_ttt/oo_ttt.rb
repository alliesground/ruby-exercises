require 'pry'

class Board
  attr_reader :squares

  def initialize
    setup_squares
  end

  def setup_squares
    @squares = {}
    (1..9).each { |num| @squares.merge! "#{num}" => Square.new }
  end

  def unmarked_square_keys
    squares.select { |_, square| square.mark.nil? }.keys
  end

  def display
    puts system 'clear'
    puts ' '
    puts '     |     |     '
    puts "  #{get_square_at '1'}  |  #{get_square_at '2'}  |  #{get_square_at '3'}  "
    puts '     |     |     '
    puts '-----+-----+-----'
    puts '     |     |     '
    puts "  #{get_square_at '4'}  |  #{get_square_at '5'}  |  #{get_square_at '6'}  "
    puts '     |     |     '
    puts '-----+-----+-----'
    puts '     |     |     '
    puts "  #{get_square_at '7'}  |  #{get_square_at '8'}  |  #{get_square_at '9'}  "
    puts '     |     |     '
    puts '-----+-----+-----'
    puts ' '
  end

  def full?
    unmarked_square_keys.empty?
  end

  private

  def get_square_at(index)
    squares[index].mark.nil? ? index : squares[index].mark
  end
end

class Player
  attr_accessor :type, :name

  def initialize(type = 'human')
    @type = type
    set_name
  end

  def set_name
    if human?
      choice = ''
      loop do
        puts 'Please enter your name'
        choice = gets.chomp
        break unless choice.empty?
        puts 'Invalid choice'
      end
      self.name = choice
    else
      self.name = ['RTD2', 'Nano', 'T-257'].sample
    end
  end

  def human?
    type == 'human'
  end
end

class Square
  attr_accessor :mark

  def initialize; end
end

# orchestration class
class TTTGame
  WINNING_LINES = [%w(1 2 3), %w(4 5 6), %w(7 8 9)] +
                  [%w(1 4 7), %w(2 5 8), %w(3 6 9)] +
                  [%w(1 5 9), %w(3 5 7)]

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  attr_accessor :human, :computer
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new 'computer'
    @current_marker = HUMAN_MARKER
  end

  def play
    display_welcome_message
    board.display

    loop do
      current_player_marks_board
      break if someone_won? || board.full?
      board.display
    end

    # display_winner
    if someone_won?
      display_winner
    else
      puts "it's a tie!"
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts 'Hello, Welcome to the game!'
  end

  def display_goodbye_message
    puts 'Until next time, good bye!'
  end

  def detect_winner
    WINNING_LINES.each do |line|
      squares = board.squares.values_at(*line)
      if squares.count { |square| square.mark == HUMAN_MARKER } == 3
        return human
      elsif squares.count { |square| square.mark == COMPUTER_MARKER } == 3
        return computer
      end
    end

    nil
  end

  def someone_won?
    !!detect_winner
  end

  def display_winner
    puts "Congrats #{detect_winner.name} won!" if someone_won?
  end

  def human_moves
    puts "Choose a square from #{board.unmarked_square_keys.join(', ')}"
    choice = ''
    loop do
      choice = gets.chomp
      break if board.unmarked_square_keys.include? choice
      puts "Invalid choice. Please choose from #{board.unmarked_square_keys.join(', ')}"
    end
    board.squares[choice].mark = HUMAN_MARKER
  end

  def computer_moves
    choice = board.unmarked_square_keys.sample
    board.squares[choice].mark = COMPUTER_MARKER
  end

  def current_player_marks_board
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end
end

TTTGame.new.play
