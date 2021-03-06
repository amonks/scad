module RB_Scad
  class Primitive < Solid
    include Defaultable

    def is_primitive?
      true
    end

    def initialize(opts = {})
      set_opts opts
    end

    def to_scad
      Solid.new(self).to_scad
    end

    def to_file
      Solid.new(self).to_file
    end
  end
end
