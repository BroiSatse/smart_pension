require 'terminal-table'
require 'log_parser/helpers/callable'

module LogParser
  module CLI
    module Presenters
      class Pretty
        # Human friendly presenter
        include Callable

        def initialize(data)
          @data = data
        end

        def call
          Terminal::Table.new(rows: data).to_s
        end

        private

        attr_reader :data
      end
    end
  end
end
