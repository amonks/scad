module RB_Scad
  class Sphere < Primitive
    self.defaults[:radius] = 1
    self.defaults[:resolution] = 24

    def to_scad
      %Q|
        sphere(#{@options[:radius]}, $fn=#{@options[:resolution]});
      |
    end
  end
end
