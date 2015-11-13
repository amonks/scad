module RB_Scad
  class Tube < Cylinder
    self.defaults[:beginning_radius] = 1
    self.defaults[:end_radius] = 1
    self.defaults[:length] = 2
    self.defaults[:thickness] = 0.5

    def to_scad
      binding.pry
      Difference.new(
        Cylinder.new(),
        Cylinder.new({
          beginning_radius: @options[:start_radius] - @options[:thickness],
          end_radius: @options[:end_radius] - @options[:thickness]
        })
      ).to_scad
    end
  end
end
