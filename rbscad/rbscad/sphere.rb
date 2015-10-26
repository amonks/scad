require_relative 'solid.rb'

module RB_Scad
  class Sphere < RB_Scad::Solid

    attr_accessor :radius, :resolution, :transforms

    def initialize( radius, transforms = nil, resolution = 8 )
      @radius = radius
      @transforms = transforms
      @resolution = resolution
    end

    def to_scad
      scad = ""
      if @transforms
        scad << @transforms.map {|t| t.to_scad}.reduce(:<<)
      end

      scad << %Q|
        sphere(#{@radius}, fn=#{@resolution});
      |
      scad
    end
  end
end
