module RB_Scad
  class MultiTrumpet < Primitive
    self.defaults[:start] = Rational(5, 100)
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

      [1, 3, 5].each do |i|
        interiors.push(Horn.new({
          start: 0,
          end: @options[:count],
          count: @options[:count],
          start_radius: @options[:start_radius] - @options[:thickness],
          end_radius: @options[:end_radius] - @options[:thickness],
          length: @options[:length],
          z_multiplier: @options[:z_multiplier] * i,
          resolution: @options[:resolution]
        }))
        exteriors.push(Horn.new({
          count: @options[:count],
          start: @start,
          end: @end,
          start_radius: @options[:start_radius],
          end_radius: @options[:end_radius],
          length: @options[:length],
          z_multiplier: @options[:z_multiplier] * i,
          resolution: @options[:resolution]
        }))
      end

      Difference.new(
        Union.new(exteriors),
        Union.new(interiors)
      ).to_scad
    end
  end
end
