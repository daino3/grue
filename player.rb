class Player
  attr_reader :room

  def initialize(map)
    @starting_room = map.keys.sample
    @gem_bag = []
  end

end