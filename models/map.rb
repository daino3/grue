class Map
  attr_reader :rooms

  def initialize(*rooms)
    @rooms = rooms
  end
end