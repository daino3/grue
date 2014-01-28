require 'pry'
require_relative 'jewel'

class Grue
  attr_reader :position, :gems

  def initialize(position, gem_count = nil)
    @position = position
    @gem_count = gem_count || 5
    @gems = get_gems
  end

  def get_gems
    gems = []
    @gem_count.times do
      gems << Jewel.new 
    end
    gems
  end

  def total_grue_worth
    @gems.map(&:worth).inject(:+)
  end

end