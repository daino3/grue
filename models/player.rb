class Player
  attr_reader :position, :gem_bag

  def initialize(position)
    @position = position
    @gem_bag  = []
  end

end