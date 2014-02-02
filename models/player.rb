class Player
  attr_accessor :position, :gems

  def initialize(position)
    @position = position
    @gems  = []
  end

  def gem_worth
    @gems.map(&:worth).inject(:+)
  end

end