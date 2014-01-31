require 'pry'

class Room
  attr_reader :name, :doors, :contents

  def initialize(name, doors)
    @name = name
    @doors = doors
    @contents = []
  end

  def outbound_doors
    doors.values.compact
  end

end