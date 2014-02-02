class Jewel
  attr_reader :name, :type, :color

  COLORS = { green: 0.7, red: 1.3, yellow: 0.5, orange: 1.0, purple: 0.2, blue: 1.5}
  GEM_TYPES = {"Gem of Azeroth" => 5, "Gem of Totality" => 8, "Gem of the Peasants" => 2, "Gem of the Warlord" => 7, "Gem of the Gods" => 10}

  def initialize
    @color = color
    @type  = type
    @name  = "#{@color} #{@type}"
  end

  def type
    @name = GEM_TYPES.keys.sample
  end

  def worth
    @worth = (GEM_TYPES[@type]*COLORS[@color]).round 
  end

  def color
    @color = COLORS.keys.sample
  end

  def define_gem
    "You picked up a #{@name}. It's worth #{self.worth} tokens!"
  end

end