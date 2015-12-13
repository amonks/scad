module RB_Scad
  class MultiTrumpet < Primitive
    self.defaults[:start] = Rational(9, 100)
    self.defaults[:pin] = Rational(20, 100)
    self.defaults[:end] = Rational(95, 100)
    self.defaults[:count] = 30
    self.defaults[:length] = 100
    self.defaults[:thickness] = 1
    self.defaults[:start_radius] = 5
    self.defaults[:end_radius] = 10
    self.defaults[:z_multiplier] = 2
    self.defaults[:resolution] = 8

    def initialize *args, &block
      super *args, &block
      @start = (@options[:start] * @options[:count]).to_i
      @end = (@options[:end] * @options[:count]).to_i
    end

    def to_scad
      interiors = []
      exteriors = []

      [2, 3, 5].each_with_index do |i, k|
        exterior = Horn.new({
          count: @options[:count],
          start: @start,
          end: @end,
          start_radius: @options[:start_radius],
          end_radius: @options[:end_radius],
          length: @options[:length],
          z_multiplier: @options[:z_multiplier] * i,
          resolution: @options[:resolution]
        })
        # pin = (self.defaults[:pin] * self.defaults[:count]).floor
        # x_offset = exterior.position(pin)[0]
        # y_offset = exterior.position(pin)[1]
        # z_offset = exterior.position(pin)[2]
        # t = [Transform.new(
        #   :translate,
        #   [0 + x_offset, 0 + y_offset, (k * self.defaults[:start_radius] - self.defaults[:thickness]) - z_offset]
        # )]
        interiors.push(Solid.new(Horn.new({
          start: 0,
          end: @options[:count],
          count: @options[:count],
          start_radius: @options[:start_radius] - @options[:thickness],
          end_radius: @options[:end_radius] - @options[:thickness],
          length: @options[:length],
          z_multiplier: @options[:z_multiplier] * i,
          resolution: @options[:resolution]
        })))

        exteriors.push(Solid.new(exterior))
      end

      # Difference.new(
      #   Union.new(exteriors),
      #   Union.new(interiors)
      # ).to_scad
      interiors.each_with_index.map{ |x, i| x.to_file "interior#{i}.scad" }
      exteriors.each_with_index.map{ |x, i| x.to_file "exterior#{i}.scad" }
    end
  end
end
