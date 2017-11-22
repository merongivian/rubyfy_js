require 'native'
require 'js'
require 'active_support/core_ext/string'

require_relative 'wrappable/js_object'

module Wrappable
  def self.included(klass)
    klass.extend Helpers

    js_object = JSObject.new(klass)

    klass.class_eval {
      include Native

      js_object.properties(:methods).each do |js_method|
        alias_native(js_method.underscore, js_method)
      end

      js_object.properties(:attributes).each do |js_attribute|
        define_method "#{js_attribute.underscore}=" do |value|
          Native(`#@native[js_attribute] = value`)
        end

        alias_native(js_attribute.underscore, js_attribute)

        define_method js_attribute.underscore do
          attribute_value = Native(`#@native[js_attribute]`)
          wrapped_class = @@wrapped_classes.find do |wrapped_klass|
            `#@native[js_attribute].constructor == eval(#{wrapped_klass.to_s})`
          end

          if wrapped_class
            wrapped_class.new(attribute_value.to_n)
          else
            attribute_value
          end
        end
      end

      def initialize(*args)
        if args.size == 1 && Kernel.native?(args.first)
          super args.first
        else
          super JSObject.new(self.class).construct(args)
        end
      end
    }
  end

  module Helpers
    @@wrapped_classes = []

    def wrapped_classes(*klasses)
      @@wrapped_classes = klasses
    end
  end
end
