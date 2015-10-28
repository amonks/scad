require_relative 'solid.rb'

module RB_Scad
  class Hull < RB_Scad::Solid

    attr_accessor :summands

    def initialize(summands)
      raise "can only union solids" unless summands.map(&:is_solid?).all?

      @summands = summands
    end

    def to_scad
      %Q|
        hull() {
          #{summands.map(&:to_scad).join}
        }
      |
    end
  end
end
