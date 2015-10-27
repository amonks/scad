module RB_Scad
  class Parametric
    include Defaultable

    self.defaults = {
      count: 30,
      precision: 10
    }

    attr_accessor :fn

    def is_parametric?
      true
    end

    def initialize(options = {})
      @fn = method(:fn)
    end

    def to_scad
      o = (1 .. @options[:count] - 1).map { |i|
        t = i.to_f
        position = find_point_by_u t
        theta = t * @options[:rotation]

        # r = (i / 300.0) ** 2 + @options[:start_radius]
        r = 0.0001

        sphere = Solid.new(Sphere.new({radius: r}))
        sphere.transform(:rotate, [0, 0, theta])
        sphere.transform(:translate, position)

        sphere
      }
      Union.new(o).to_scad
    end

    def to_file
      Solid.new(self).to_file
    end

    def parameterize_normal(fn, precision = 10)
      fn
    end

    private

    def calculate_arc_lengths
      points = (0..@options[:precision] + 1).map {|t|
        @fn.call(t)
      }
      prev = 0

      points.map.with_index {|p, i|
        i == 0 ? 0 : distance(points[i - 1], p)
      }.collect {|v| prev += v}
    end

    def find_t_by_u u
      # @fn.call(u)
      target_length = u * @arc_length / @options[:count]

      low = 0
      high = @arc_lengths.length
      index = 0

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
      @fn.call(t)
    end
  end
end
