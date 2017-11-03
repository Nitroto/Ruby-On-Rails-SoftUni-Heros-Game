class Hero
  attr_reader :strength, :is_alive, :vitality, :name, :nickname

  def initialize(identity, strength)
    @vitality = 100
    @name = identity.name
    @nickname = identity.nickname
    @strength = strength
    @is_alive = true
  end

  def hit(other, impact)
    other.gets_hit(impact)
  end

  def gets_hit(impact)
    @vitality -= impact
    @is_alive = false if @vitality <= 0
  end

  def to_s
    "Name: #{@name}\nNickname: #{@nickname}\nStrength: #{@strength}"
  end
end