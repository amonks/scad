require_relative 'solid.rb'

module RB_Scad
  class Union < RB_Scad::Solid

    attr_accessor :summands

    def initialize(summands)
      raise "can only union solids" unless summands.map(&:is_solid?).all?

      @summands = summands
    end

    def to_scad
      %Q|
        union() {
          #{summands.map(&:to_scad).join}
        }
      |
    end
  end
end
