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

      native_accessor *(js_object.properties :attributes)

      def initialize(*args)
        super JSObject.new(self.class).construct(args)
      end
    }
  end
end
