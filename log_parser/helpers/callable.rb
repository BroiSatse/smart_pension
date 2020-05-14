module LogParser
  module Callable
    # Some sugar to make calling objects simpler

    def self.included(mod)
      mod.extend ClassMethods
    end

    module ClassMethods
      def call(*args, &block)
        new(*args).call(&block)
      end
    end
  end
end
