require 'native'
require 'js'
require 'active_support/core_ext/string'

require_relative 'wrappable/js_object'

module Wrappable
  def self.included(klass)
    js_object = JSObject.new(klass)
    js_window_objects = Native(`Object.getOwnPropertyNames(window)`)

    klass.class_eval {
      include Native

      js_object.properties(:methods).each do |js_method|
        alias_native(js_method.underscore, js_method)
      end

      js_object.properties(:attributes).each do |js_attribute|
        define_method "#{js_attribute.underscore}=" do |value|
          Native(`#@native[js_attribute] = value`)
        end

        define_method js_attribute.underscore do
          attribute_value = Native(`#@native[js_attribute]`)
          wrapped_class_string = js_window_objects.find do |js_window_object|
            `#@native[js_attribute].constructor == window[js_window_object]`
          end

          is_wrapped_class = Kernel.const_defined?(wrapped_class_string) &&
                             Object.const_get(wrapped_class_string).is_a?(Class) &&
                             Object.const_get(wrapped_class_string).ancestors.include?(Native)

          if wrapped_c && is_wrapped_class
            Object.const_get(wrapped_class_string).new(attribute_value.to_n)
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
end
