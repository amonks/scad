module RB_Scad
  class Sphere < Primitive
    self.defaults = {
      radius: 1,
      resolution: 8
    }

    def to_scad
      %Q|
        sphere(#{@options[:radius]}, $fn=#{@options[:resolution]});
      |
    end
  end
end