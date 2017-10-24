require './hero.rb'

class GoodGuy < Hero

  @special_skill


  def initialize(identity, strength, special_skill)
    super(identity, strength)

    @special_skill = special_skill
  end

  def to_s
    super + "\nSpecial skill: #{@special_skill}"
  end
end