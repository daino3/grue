class Room
  attr_accessor :gems, :dais
  attr_reader :name, :doors

  def initialize(name, doors, dais=nil)
    @name = name
    @doors = doors
    @gems = []
    @dais = dais
  end

  def outbound_doors
    doors.values.compact
  end

end