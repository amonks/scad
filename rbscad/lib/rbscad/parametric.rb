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

    def initialize(opts = {})
      set_opts opts
      @fn = method(:fn)
    end

    def to_scad
      spheres = positions.map.with_index{|p, i|
        # r = i * 5 / @options[:count].to_f + 1
        r = 1

        sphere = Solid.new(Sphere.new({radius: r, resolution: @options[:resolution]}))
        sphere.transform(:rotate, [0, 0, i])
        sphere.transform(:translate, p)

        sphere
      }
      Union.new(spheres).to_scad
    end

    def positions
      (0 .. @options[:count] - 1).map { |i|
        target_length = i.to_f / @options[:count] * @options[:length]
        t = find_t_by_target_length target_length
        position = @fn.call t

        position
      }
    end

    def to_file
      Solid.new(self).to_file
    end

    def parameterize_normal(fn, precision = 10)
      fn
    end

    private

    def calculate_arc_lengths
      points = []
      lengths = [0]
      i = 0
      until lengths.last > @options[:length]
        point = @fn.call(i)
        points.push point
        if i > 0
          length = lengths[i - 1] + distance(point, points[i-1])
          lengths.push length
        end
        i += 1
      end
      lengths
    end

    def find_t_by_target_length target_length
      length_after = @arc_lengths.bsearch{|x| x >= target_length }
      index_after = @arc_lengths.find_index length_after
      index_before = index_after - 1
      length_before = @arc_lengths[index_before]

      length = length_after - length_before
      difference = target_length - length_before
      target_index = index_before + difference / length

      target_index
    end

    def find_point_by_target_length target_length
      t = find_t_by_target_length target_length
      @fn.call(t)
    end
  end
end
