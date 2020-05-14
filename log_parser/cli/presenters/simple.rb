require 'log_parser/helpers/callable'

module LogParser
  module CLI
    module Presenters
      class Simple
        # Simple presenter, easy to used within pipeline
        include Callable

        def initialize(data)
          @data = data
        end

        def call
          data
            .map { |row| row.join("\t") }
            .join("\n")
        end

        private

        attr_reader :data
      end
    end
  end
end
