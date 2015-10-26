require_relative 'solid.rb'

module RB_Scad
  class Difference < RB_Scad::Solid

    attr_accessor :minuend, :subtrahend

    def initialize(minuend, subtrahend)
      unless minuend.is_solid? && subtrahend.is_solid?
        raise "Minuend and subtrahend must be instances of RB_Scad::Solid"
      end

      @minuend = minuend
      @subtrahend = subtrahend
    end

    def to_scad
      %Q|
        difference() {
          #{@minuend.to_scad}
          #{@subtrahend.to_scad}
        }
      |
    end
  end
end
