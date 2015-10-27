module RB_Scad
  module Defaultable
    extend ActiveSupport::Concern

    included do
      class_attribute :defaults
      set_opts
      # @defaults.each do |k, v|
      #   attr_accessor k
      # end
    end

    module ClassMethods
      def set_opts(options = {})
        @options = Hash[self.defaults.map {|k, v|
          [k, (options[k] || v)]
        }]
      end
    end
  end
end
