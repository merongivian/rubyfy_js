require 'native'
require 'active_support/core_ext/string'

module Wrappable
  def self.included(klass)
    klass.class_eval {
      include Native

      # NOTE: identifies methods that start with underscore as private methods
      js_properties = (Array(`Object.getOwnPropertyNames(window[#{klass}].prototype)`) - ['constructor']).reject { |method| method.start_with? '_' }
      js_properties.each do |js_method|
        alias_native(js_method.underscore, js_method)
      end

      # TODO: this is duplicating method creation, extract-refactor
      attributes = `Object.getOwnPropertyNames(#{Helper.constructor(klass, [])})`

      native_accessor *attributes

      def initialize(*args)
        super Helper.constructor(self.class, args)
      end
    }
  end

  module Helper
    def self.constructor(klass, args)
      #NOTE some javascript dark magic for applying attributes on new,
      #see: http://stackoverflow.com/questions/1606797/use-of-apply-with-new-operator-is-this-possible
      %x{
        function construct(constructor, argums) {
            function F() {
              return window[constructor].apply(this, argums);
            }
            F.prototype = window[constructor].prototype;
            return new F();
        }
      }

      `construct(#{klass}, args)`
    end
  end
end
