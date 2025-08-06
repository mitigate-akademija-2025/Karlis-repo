class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end


class Animal
    attr_accessor  :name, :legs_count
    def initialize(name, legs_count)
        @name = name
        @legs_count = legs_count
    end

    def speak
      puts "roar"
    end
end

lion = Animal.new("Lion", 5)
lion.speak

class Dog
  def initialize(name, legs_count)
    @name = name
    @legs_count = legs_count
  end

  def speak
    puts "vau vau"
  end
end


doggo = Dog.new("Sunis", 6)
doggo.speak


class AnotherCat < Animal
  def speak
    super
    puts "meow"
  end
end

bobcat = AnotherCat.new("Bobcat", 4)
bobcat.speak



