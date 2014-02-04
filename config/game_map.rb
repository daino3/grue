require_relative '../models/room'
require_relative '../models/map'

chartreuse   = Room.new("Chartreuse", {north: "Ochre", east: nil, south: "Emerald", west: nil})
ochre        = Room.new("Ochre", {north: "Vermillion", east: "Chartreuse", south: nil, west: nil})
vermillion   = Room.new("Vermillion", {north: nil, east: "Ochre", south: "Aquamarine", west: nil})
aquamarine   = Room.new("Aquamarine", {north: nil, east: nil, south: "Violet", west: "Cobalt"})
lavender     = Room.new("Lavender",{north: nil, east: "Chartreuse", south: nil, west: "Burnt Sienna"})
emerald      = Room.new("Emerald", {north: nil, east: "Lavender", south: "Aquamarine", west: "Cobalt"})
cobalt       = Room.new("Cobalt", {north: "Vermillion", east: nil, south: "Burnt Sienna", west: nil})
violet       = Room.new("Violet", {north: nil, east: "Burnt Sienna", south: nil, west: "Chartreuse"})
burnt_sienna = Room.new("Burnt Sienna", {north: "Emerald", east: "Lavender", south: nil, west: nil}, true)

TEST_ROOM = chartreuse
MAP_ROOMS = [vermillion, ochre, chartreuse, lavender, emerald, aquamarine, cobalt, violet, burnt_sienna]