require_relative 'models/room'
require_relative 'models/map'

orange = Room.new("Orange", {north: nil, east: "Blue", south: nil, west: nil})
blue   = Room.new("Blue", {north: nil, east: "Green", south: nil, west: nil})
green = Room.new("Green", {north: nil, east: "Purple", south: nil, west: nil})
purple = Room.new("Purple", {north: nil, east: nil, south: nil, west: nil})

test_rooms = [orange, blue, green, purple]

test = Map.new(*test_rooms)

test.shortest_path(orange, purple)