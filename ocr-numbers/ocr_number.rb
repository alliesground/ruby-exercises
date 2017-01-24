require 'pry'

class OCR
  attr_reader :text

  PATTERNS = {
               ' _ | ||_|' => '0',
               '     |  |' => '1',
               ' _  _||_ ' => '2',
               ' _  _| _|' => '3',
               '   |_|  |' => '4',
               ' _ |_  _|' => '5',
               ' _ |_ |_|' => '6',
               ' _   |  |' => '7',
               ' _ |_||_|' => '8',
               ' _ |_| _|' => '9'
             }

  def initialize(text)
    @text = text
  end

  def convert
    decode_digit(parse text)
  end


  private

  def parse(input)
    rows = input.split("\n")
    max_length_row = rows.max_by { |row| row.length }
    max_row_size = max_length_row.size

    rows = rows.map do |row|
             row += ' ' * (max_row_size - row.size)
           end

    rows.join
  end

  def decode_digit(input)
    PATTERNS[input] || '?'
  end
end
