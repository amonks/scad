# see http://gamedev.stackexchange.com/questions/5373/moving-ships-between-two-planets-along-a-bezier-missing-some-equations-for-acce/5427#5427?newreg=0ed63fed87994d969f944246b69bc110

module RB_Scad
  class Spiral < Parametric
    self.defaults = {
      count: 30,
      length: 100,
      start_radius: 1,
      end_radius: 2,
      coil_radius: 3,
      coil_height: 2,
      resolution: 30,
      precision: 10
    }

    def initialize(*args, &block)
      super(*args, &block)
      @arc_lengths = calculate_arc_lengths
      @arc_length = @arc_lengths.last
    end

    def fn t
      amplitude = t * @options[:coil_radius]
      x = Math.cos(t) * amplitude
      y = Math.sin(t) * amplitude
      z = t * 1.2

      [x, y, z]
    end
  end
end
