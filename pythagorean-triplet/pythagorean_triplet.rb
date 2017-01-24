require 'pry'

class Triplet
  attr_reader :numbers

  def self.where(options)
    triplets = []
    max_factor = options[:max_factor] || 1
    min_factor = options[:min_factor] || 1

    factors = (min_factor..max_factor).to_a

    factors.combination(3).each do |a, b, c|
      triplet = Triplet.new(a, b, c)
      triplets << triplet if triplet.pythagorean?
    end

    triplets
  end

  def initialize(*numbers)
    @numbers = numbers
  end

  def sum
    numbers.inject(:+)
  end

  def product
    numbers.inject(:*)
  end

  def pythagorean?
    (numbers[0]**2) + (numbers[1]**2) == (numbers[2]**2)
  end

  private

  def self.factors_of(triplet)
    triplet.numbers
  end
end

