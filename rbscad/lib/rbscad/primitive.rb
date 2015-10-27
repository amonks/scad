module RB_Scad
  class Primitive
    class_attribute :defaults
    self.defaults = {}

    class << self
      def inherited(sub)
        self.defaults.each do |k, v|
          attr_accessor k
        end
      end
    end

    def is_primitive?
      true
    end

    def initialize(options = {})
      @options = Hash[self.defaults.map {|k, v|
        [k, (options[k] || v)]
      }]
    end

    def to_scad
      Solid.new(self).to_scad
    end

    def to_file
      Solid.new(self).to_file
    end
  end
end

require_relative 'primitives/sphere.rb'
require_relative 'primitives/spiral.rb'
