class Game
  attr_reader :map, :player, :gruel

  def initialize
    @map = Map.new
    @player = Player.new(@map)
    @gruel = Gruel.new(@map, @player)
  end

end