class Gruel
  attr_reader :room

  def initialize(map)
    @starting_room = map.sample
  end

end