require_relative 'models/room'
require_relative 'models/map'

orange  = Room.new("Orange", {north: nil, east: "Blue", south: "Green", west: nil})
blue    = Room.new("Blue", {north: "Cobalt", east: "Purple", south: nil, west: nil})
cobalt  = Room.new("Cobalt", {north: nil, east: "Yellow", south: nil, west: nil})
purple  = Room.new("Purple", {north: nil, east: nil, south: nil, west: nil})
yellow  = Room.new("Yellow", {north: nil, east: nil, south: "Purple", west: nil})
green   = Room.new("Green", {north: nil, east: nil, south: "Magenta", west: nil})
magenta = Room.new("Magenta", {north: nil, east: nil, south: nil, west: nil})
rainbow = Room.new("Rainbow", {north: nil})

test_rooms = [orange, blue, cobalt, yellow, green, magenta, purple]

test = Map.new(*test_rooms)

test.shortest_path(orange, purple)

# print routes, "\n" 
# test.find_room_by_name("Green")