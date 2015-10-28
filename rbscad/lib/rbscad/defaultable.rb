module RB_Scad
  module Defaultable
    def self.included(subclass)
      subclass.class_attribute :defaults
    end

    def set_opts(options = {})
      @options = Hash[self.class.defaults.map {|k, v|
        [k, (options[k] || v)]
      }]
    end
  end
end
