module RB_Scad
  class Primitive
    include Defaultable

    def is_primitive?
      true
    end

    def initialize(options = {})
      set_opts
    end

    def to_scad
      Solid.new(self).to_scad
    end

    def to_file
      Solid.new(self).to_file
    end
  end
end
