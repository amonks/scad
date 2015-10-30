# see http://gamedev.stackexchange.com/questions/5373/moving-ships-between-two-planets-along-a-bezier-missing-some-equations-for-acce/5427#5427?newreg=0ed63fed87994d969f944246b69bc110

module RB_Scad
  class Spiral < Parametric
    self.defaults[:coil_radius] = 3
    self.defaults[:start] = 0
    self.defaults[:z_multiplier] = 2

    def initialize(*args, &block)
      super(*args, &block)
      @arc_lengths = calculate_arc_lengths
      @arc_length = @arc_lengths.last
    end

    def fn t
      amplitude = t * @options[:coil_radius]
      x = Math.cos(t) * amplitude
      y = Math.sin(t) * amplitude
      z = t * @options[:z_multiplier]

      [x, y, z]
    end
  end
end
