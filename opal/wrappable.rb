require 'native'
require 'js'

require 'active_support/core_ext/string'

require_relative 'wrappable/js_object'

module Wrappable
  def self.included(klass)
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
      end

      def initialize(*args)
        super JSObject.new(self.class).construct(args)
      end
    }
  end
end
