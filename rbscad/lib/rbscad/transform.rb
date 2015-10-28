module RB_Scad
  class Transform
    attr_accessor :transform
    attr_accessor :vector

    def is_transform?
      true
    end

    def initialize(transform, vector)
      @transform = transform
      @vector = vector
    end

    def to_scad
      %Q|
        #{transform}(#{vector.map{|v| "%.15f" % v}.to_s.gsub('"', '')})
      |
    end
  end
end
