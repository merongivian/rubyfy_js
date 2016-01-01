require 'native'
require 'js'

require 'active_support/core_ext/string'

module Wrappable
  def self.included(klass)
    klass.class_eval {
      include Native

      # NOTE: identifies methods that start with underscore as private methods
      js_properties = (JSHelpers.object_properties(JSHelpers.window(klass).JS[:prototype]) - %w(constructor)).reject { |method| method.start_with? '_' }

      js_properties.each do |js_method|
        alias_native(js_method.underscore, js_method)
      end

      # TODO: this is duplicating method creation, extract-refactor
      attributes = JSHelpers.object_properties(JSHelpers.constructor klass)

      native_accessor *attributes

      def initialize(*args)
        super JSHelpers.constructor(self.class, args)
      end
    }
  end

  module JSHelpers
    def self.constructor(property, args = [])
      JS.new(window(property), args)
    end

    def self.object_properties(object)
      Array(`Object`.JS.getOwnPropertyNames(object))
    end

    def self.window(property)
      `window`.JS[property]
    end
  end
end
