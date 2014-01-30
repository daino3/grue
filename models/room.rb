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

vermillion   = Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil})
ochre        = Room.new("Ochre", {north: nil, east: "Chartreuse", south: nil, west: "Vermillion"})
chartreuse   = Room.new("Chartreuse", {north: nil, east: "Ochre", south: "Emerald", west: nil})
lavender     = Room.new("Lavender",{north: "Chartreuse", east: nil, south: "Burnt Sienna", west: nil})
emerald      = Room.new("Emerald", {north: nil, east: "Lavender", south: "Aquamarin", west: "Cobalt"})
aquamarine   = Room.new("Aquamarine", {north: nil, east: nil, south: "Violet", west: "Cobalt"})
cobalt       = Room.new("Cobalt", {north: "Vermillion", east: nil, south: "Burnt Sienna", west: nil})
violet       = Room.new("Violet", {north: nil, east: "Burnt Sienna", south: "Chartreuse", west: nil})
burnt_sienna = Room.new("Burnt Sienna", {north: "Emerald", east: "Lavender", south: nil, west: nil})