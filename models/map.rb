require_relative 'shortest_path'

class Map
  attr_reader :rooms 

  def initialize(*rooms)
    @rooms = rooms
  end

  def shortest_path(source, destination)
    new_path = ShortestPath.new(self, source, destination)
    next_room = new_path.find_path
  end

  def find_room_by_name(name)
    @rooms.find do |room_obj| 
      room_obj.name == name
    end
  end

end