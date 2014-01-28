class Game
  attr_reader :map, :player, :gruel

  def initialize(map, player, grue)
    @map = map
    @player = player
    @grue = grue
    @dead? = false
  end

end