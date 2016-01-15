require 'pry'

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end
=begin
bob = Person.new('Sam')
puts bob.name
puts bob.first_name
puts bob.last_name
bob.last_name = 'Smith'
puts bob.name

bob.name = "John Adams"
puts bob.first_name
puts bob.last_name

jade = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

puts jade.name == rob.name
puts jade.name
puts jade
=end

module Swimable
  def swim
    'swim!'
  end
end

module Huggable
  def hugg
    'hugging'
  end
end

class Pet 
  attr_accessor :name, :move

  def initialize
    @move = 'moving!'
  end
end

class Mammal < Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Fish < Pet
  include Swimable
  include Huggable
end

class Dog < Mammal
  include Swimable

  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def initialize
    set_name
  end

  def set_name
    puts "Please enter you name"
    self.name = gets.chomp
  end

  def swim
    "can't swim!"
  end
end

class Zendog < Dog
  def initialize(name)
    @name = name
    @move = 'not moving!'
  end
end

class Cat < Mammal
  def speak
    'meow!'
  end
end

dan = Bulldog.new
puts dan.speak
puts dan.swim
puts dan.name
puts dan.move
puts "*******"

zen = Zendog.new 'Zenny'
puts zen.name
puts zen.move
puts "*******"

billu = Dog.new
puts billu.speak
puts billu.swim

catty = Cat.new
puts catty.speak
puts catty.run
puts catty.jump

nemo = Fish.new
puts nemo.swim 
puts nemo.class.ancestors
