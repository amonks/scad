class Class
  def class_attribute(*attrs)
    options = attrs.extract_options!
    instance_reader = options.fetch(:instance_accessor, true) && options.fetch(:instance_reader, true)
    instance_writer = options.fetch(:instance_accessor, true) && options.fetch(:instance_writer, true)
    instance_predicate = options.fetch(:instance_predicate, true)

    attrs.each do |name|
      define_singleton_method(name) { nil }
      define_singleton_method("#{name}?") { !!public_send(name) } if instance_predicate

      ivar = "@#{name}"

      define_singleton_method("#{name}=") do |val|
        singleton_class.class_eval do
          remove_possible_method(name)
          define_method(name) { val }
        end

        if singleton_class?
          class_eval do
            remove_possible_method(name)
            define_method(name) do
              if instance_variable_defined? ivar
                instance_variable_get ivar
              else
                singleton_class.send name
              end
            end
          end
        end
        val
      end

      if instance_reader
        remove_possible_method name
        define_method(name) do
          if instance_variable_defined?(ivar)
            instance_variable_get ivar
          else
            self.class.public_send name
          end
        end
        define_method("#{name}?") { !!public_send(name) } if instance_predicate
      end

      attr_writer name if instance_writer
    end
  end
end


class Array
  def extract_options!
    if last.is_a?(Hash) && last.extractable_options?
      pop
    else
      {}
    end
  end
end

class Module
  def remove_possible_method(method)
    if method_defined?(method) || private_method_defined?(method)
      undef_method(method)
    end
  end
end
