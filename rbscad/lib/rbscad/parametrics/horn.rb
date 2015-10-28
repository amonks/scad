# see http://gamedev.stackexchange.com/questions/5373/moving-ships-between-two-planets-along-a-bezier-missing-some-equations-for-acce/5427#5427?newreg=0ed63fed87994d969f944246b69bc110

module RB_Scad
  class Horn < Spiral
    self.defaults[:start_radius] = 1
    self.defaults[:end_radius] = 5

    def radius i
      per = percent i
      difference = @options[:end_radius] - @options[:start_radius]
      per * difference + @options[:start_radius]
    end
  end
end
