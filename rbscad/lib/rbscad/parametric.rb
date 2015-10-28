module RB_Scad
  class Parametric < Solid
    include Defaultable

    self.defaults[:count] = 30
    self.defaults[:start] = 0
    self.defaults[:end] = self.defaults[:count]
    self.defaults[:length] = 100
    self.defaults[:resolution] = 16

    def is_parametric?
      true
    end

    def initialize(opts = {})
      set_opts opts
      @fn = method(:fn)
    end

    def to_scad
      spheres = []
      positions.each_with_index do |p, i|
        if i < positions.length - 2
          hull = Hull.new([sphere(i), sphere(i + 1)])
          spheres.push hull
        end
      end
      Union.new(spheres).to_scad
    end

    def positions
      (@options[:start] .. @options[:end] - 1).map { |i|
        target_length = (i.to_f / @options[:count]) * @options[:length]
        t = find_t_by_target_length target_length
        position = @fn.call t

        position
      }
    end

    def position i
      positions[i]
    end

    def rotation i
      [0, 0, 0]
    end

    def radius i
      1
    end

    def percent i
      i.to_f / @options[:count].to_f
    end

    def to_file
      Solid.new(self).to_file
    end

    def parameterize_normal(fn, precision = 10)
      fn
    end

    private

    def sphere i
      sphere = Solid.new(Sphere.new({radius: radius(i), resolution: @options[:resolution]}))
      sphere.transform(:rotate, rotation(i))
      sphere.transform(:translate, position(i))

      sphere
    end

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
      puts "calculated #{lengths.length} arc lengths! the longest is #{lengths.last}"
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
