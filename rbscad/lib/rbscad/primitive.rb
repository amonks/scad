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
  end
end

require_relative 'primitives/sphere.rb'
require_relative 'primitives/spiral.rb'
