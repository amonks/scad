# see http://gamedev.stackexchange.com/questions/5373/moving-ships-between-two-planets-along-a-bezier-missing-some-equations-for-acce/5427#5427?newreg=0ed63fed87994d969f944246b69bc110

module RB_Scad
  class Spiral < Primitive
    attr_reader :arc_lengths

    self.defaults = {
      count: 30,
      rotation: 2 * Math::PI,
      start_radius: 1,
      end_radius: 2,
      coil_radius: 3,
      coil_height: 2,
      resolution: 30,
      precision: 10
    }

    def initialize
      super
      @arc_lengths = calculate_arc_lengths
      # binding.pry
      @arc_length = @arc_lengths.last
    end

    def to_scad
      o = (1 .. @options[:count] - 1).map { |i|
        t = (i.to_f / @options[:count])
        position = find_point_by_u t
        theta = t * @options[:rotation]

        # r = (i / 300.0) ** 2 + @options[:start_radius]
        r = 0.1

        sphere = Solid.new(Sphere.new({radius: r}))
        sphere.transform(:rotate, [0, 0, theta])
        sphere.transform(:translate, position)

        sphere
      }
      Union.new(o).to_scad
    end

    def calculate_arc_lengths
      points = (0..@options[:precision]).map {|t|
        find_point_by_t t
      }
      prev = 0

      points.map.with_index {|p, i|
        # binding.pry
        i == 0 ? 0 : distance(points[i - 1], p)
      }.collect {|v| prev += v}
    end

    private

    def find_point_by_t t
      theta = t * @options[:rotation]
      amplitude = t * @options[:coil_radius]
      x = Math.cos(theta) * amplitude
      y = Math.sin(theta) * amplitude
      z = @options[:coil_height] * (theta / (2 * Math::PI))

      [x, y, z]
    end


    def find_t_by_u u
      # find_point_by_t u
      target_length = u * @arc_length / @options[:count]

      low = 0
      high = @arc_lengths.length
      index = 0

      # binding.pry
      while (low < high)
        index = low + ((high - low) / 2.0).to_i
        if (@arc_lengths[index] < target_length)
          low = index + 1
        else
          high = index
        end
      end
      # if (@arc_lengths[index] > target_length)
      #   index = index--
      # end

      length_before = @arc_lengths[index]
      if (length_before == target_length)
        return index / @arc_length
      else
        return (index + (target_length - length_before) / (@arc_lengths[index + 1] - length_before)) / @arc_length
      end
    end

    def find_point_by_u u
      t = find_t_by_u u
      find_point_by_t t
    end
  end
end
