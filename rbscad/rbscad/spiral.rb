require_relative 'solid.rb'

module RB_Scad
  class Spiral < RB_Scad::Solid
    attr_accessor :count,
                  :length,
                  :rotation,
                  :resolution,
                  :start_radius,
                  :end_radius

    def initialize(count, length, rotation, start_radius = 1, end_radius = 1, resolution = 15)
      @count = count
      @length = length
      @rotation = rotation
      @start_radius = start_radius
      @end_radius = end_radius
      @resolution = resolution
    end

    def to_scad
      o = (1..@count).map { |i|
        ∆ = (i.to_f / @count) * @length
        theta = (i.to_f / @count) * @rotation
        a = i / 49.0
        x = Math.cos(theta.to_radians) * a
        y = Math.sin(theta.to_radians) * a
        z = i * -0.03
        r = (i / 300.0) ** 2 + @start_radius

        rotation = Transform.new(:rotate, [0, 0, theta])
        translation = Transform.new(:translate, [x, y, z])

        Sphere.new(r, [translation, rotation])
      }.map(&:to_scad).reduce(:<<)
    end
  end
end
