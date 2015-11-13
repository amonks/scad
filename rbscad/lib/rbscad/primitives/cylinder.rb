module RB_Scad
  class Cylinder < Primitive
    self.defaults[:start_radius] = 1
    self.defaults[:end_radius] = 1
    self.defaults[:length] = 2
    self.defaults[:resolution] = 24

    def to_scad
      %Q|
        cylinder(
          h=#{@options[:length]},
          r1=#{@options[:start_radius]},
          r2=#{@options[:end_radius]},
          $fn=#{@options[:resolution]}
        );
      |
    end
  end
end
