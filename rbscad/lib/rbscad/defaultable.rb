module RB_Scad
  module Defaultable
    extend ActiveSupport::Concern

    included do
      class_attribute :defaults
    end

    class << self
      def inherited(sub)
        self.defaults.each do |k, v|
          attr_accessor k
        end
      end
    end

    def set_opts(options = {})
      @options = Hash[self.defaults.map {|k, v|
        [k, (options[k] || v)]
      }]
    end
  end
end
