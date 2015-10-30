require 'pry'
require 'logger'
require 'active_support/all'

class Numeric
  def to_radians
    self * Math::PI / 180
  end
end

# require_relative 'rbscad/class_attribute.rb'
require_relative 'rbscad/defaultable.rb'
require_relative 'rbscad/search.rb'

require_relative 'rbscad/util/distance.rb'

require_relative 'rbscad/solid.rb'
require_relative 'rbscad/transform.rb'
require_relative 'rbscad/difference.rb'
require_relative 'rbscad/union.rb'
require_relative 'rbscad/hull.rb'
require_relative 'rbscad/primitive.rb'
require_relative 'rbscad/primitives/sphere.rb'

require_relative 'rbscad/parametric.rb'
require_relative 'rbscad/parametrics/spiral.rb'
require_relative 'rbscad/parametrics/horn.rb'

require_relative 'rbscad/forms/trumpet.rb'

include RB_Scad
