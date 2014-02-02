class Player
  attr_accessor :gems

  def initialize
    @gems  = []
  end

  def gem_worth
    @gems.map(&:worth).inject(:+)
  end

end