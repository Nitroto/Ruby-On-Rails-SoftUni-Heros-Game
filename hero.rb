
class Hero
  @vitality = 100

  def initialize(identity, strength)
    @name = identity.name
    @nickname = identity.nickname
    @strength = strength
    @is_alive = true
  end

  def hit(other)
    other.gets_hit(force_of_impact)
  end

  def gets_hit(impact)
    @vitality -= impact
    @is_alive = false if @vitality <= 0
  end

  def to_s
    "Name: #{@name}\nNickname: #{@nickname}\nStrength: #{@strength}"
  end

  private

  def force_of_impact
    @strength * threw_a_dice
  end

  private

  def threw_a_dice
    rand(1..6)
  end
end