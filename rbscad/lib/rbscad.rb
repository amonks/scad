require 'pry'
require 'logger'

class Numeric
  def to_radians
    self * Math::PI / 180
  end
end

require_relative 'rbscad/util.rb'
require_relative 'rbscad/class_attribute.rb'
require_relative 'rbscad/transform.rb'
require_relative 'rbscad/difference.rb'
require_relative 'rbscad/union.rb'
require_relative 'rbscad/primitive.rb'
require_relative 'rbscad/solid.rb'

include RB_Scad
