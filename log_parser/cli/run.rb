require 'log_parser/helpers/callable'
require 'log_parser/run'

module LogParser
  module CLI
    class Run
      # This class server as a bridge between command line and the main domain of the program

      include Callable

      def initialize(options)
        @options = options
        puts options.inspect
      end

      def call
      end

      private

      attr_reader :options
    end
  end
end
