require 'pry'

class Numeric
  def to_radians
    self * Math::PI / 180
  end
end

require_relative 'rbscad/transform.rb'
require_relative 'rbscad/difference.rb'
require_relative 'rbscad/sphere.rb'
require_relative 'rbscad/spiral.rb'

include RB_Scad

hank = Spiral.new(
  3, #count
  5000.0, #length
  720, #rotation
  20, #resolution
  0.01, #start_radius
  2, #end_radius
)

puts hank.to_scad
