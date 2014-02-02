require 'pry'

class Room
  attr_accessor :gems
  attr_reader :name, :doors, :dias

  def initialize(name, doors, dias=nil)
    @name = name
    @doors = doors
    @gems = []
    @dias = dias
  end

  def outbound_doors
    doors.values.compact
  end

end