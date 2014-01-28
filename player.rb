class Player
  attr_reader :room

  def initialize(position)
    @position = position
    @gem_bag  = []
  end

end