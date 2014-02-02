require 'pry'
require_relative 'jewel'

class Grue
  attr_accessor :gems

  def initialize(gem_count = nil)
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

  def gem_worth
    @gems.map(&:worth).inject(:+)
  end

end