module Wrappable
  class JSObject
    def initialize(name)
      @name = name
    end

    def construct(args = [])
      JS.new(obtain, *args)
    end

    def properties(type)
      if type == :methods
        # NOTE: identifies methods that start with underscore as private methods
        (property_names(prototype) - %w(constructor))
          .reject { |method| method.start_with? '_' }
      elsif type == :attributes
        Array(property_names construct)
      else
        fail 'incorrect type'
      end
    end

    private

    def property_names(object)
      `Object`.JS.getOwnPropertyNames object
    end

    def prototype
      obtain.JS[:prototype]
    end

    def obtain
      `window`.JS[@name]
    end
  end
end
