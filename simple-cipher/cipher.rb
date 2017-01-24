require 'pry'

class Cipher
  attr_accessor :key

  ALPHABET = [*('a'..'z')]

  def initialize(key=nil) 
    validate!(key)
    @key = key || (ALPHABET.shuffle * 4).pop(100).join
  end

  def encode(plaintext) 
    result = ''

    plaintext.chars.each_with_index do |letter, idx| 
      key_letter = key[idx]
      shift_dist = ALPHABET.index(key_letter)
      new_letter = find_new_letter(letter, shift_dist)
      result += new_letter
    end

    result
  end

  def decode(ciphertext)
    result = ''
    
    ciphertext.chars.each_with_index do |letter, idx|
      key_letter = key[idx]
      shift_dist = ALPHABET.index(key_letter)
      original_letter = find_original_letter(letter, shift_dist)
      result += original_letter 
    end

    result
  end

  private

  def find_original_letter(current_letter, distance)
    current_idx = ALPHABET.index(current_letter)
    original_idx = current_idx - distance 
    while original_idx < 0
      original_idx = original_idx + 26
    end
    
    ALPHABET[original_idx]
  end

  def find_new_letter(current_letter, distance)
    current_idx = ALPHABET.index(current_letter)
    new_idx = current_idx + distance 
    new_idx = new_idx - 26 if new_idx > 25
    
    ALPHABET[new_idx]
  end

  def validate!(key)
    return if key.nil?

    raise ArgumentError, 'invalid key' if key.match(/[A-Z]|\d|^$/)
  end
end
