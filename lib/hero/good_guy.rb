require_relative '../hero.rb'

class GoodGuy < Hero
  attr_reader :special_skill
  @special_skill


  def initialize(identity, strength, special_skill)
    super(identity, strength)

    @special_skill = special_skill
  end

  def use_revive
    @special_skill = 'none'
    @vitality = 100
  end

  def to_s
    super + "\nSpecial skill: #{@special_skill}"
  end
end