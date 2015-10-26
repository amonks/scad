module RB_Scad
  class Solid
    attr_accessor :primitive,
                  :transforms

    def is_solid?
      true
    end

    def initialize(primitive, transforms = [])
      @transforms = transforms
      @primitive = primitive
    end

    def transform(transform, vector = nil)
      case transform
      when Transform
        @transforms << transform
      when Symbol
        @transforms << Transform.new(transform, vector)
      end
    end

    def to_scad
      %Q|
        #{@transforms.map {|t| t.to_scad}.reduce(:<<)}
        #{@primitive.to_scad}
      |
    end
  end
end
