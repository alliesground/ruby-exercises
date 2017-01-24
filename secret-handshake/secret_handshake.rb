class SecretHandshake
  attr_reader :binary, :commands

  SHAKE = [
            'wink',
            'double blink',
            'close your eyes',
            'jump'
          ]

  def initialize(input)
    @binary = parse input
  end

  def commands
    result = []

    return result if binary.nil?

    binary.reverse!
    binary.chars.each_with_index do |digit, idx|
      if idx >= 4 && binary[idx] == '1'
        result.reverse!
        break
      end

      if binary[idx] == '1'
        result << SHAKE[idx]
      end
    end

    result
  end

  private

  def parse(input)
    case
    when input.class == Fixnum
      input.to_s(2)
    when contains_non_binary_char?(input)
      nil
    else
      input
    end
  end

  def contains_non_binary_char?(input)
    input =~ /[^10]/
  end
end

s = SecretHandshake.new(31)
p s.commands
