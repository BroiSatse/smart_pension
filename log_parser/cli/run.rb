require 'log_parser/helpers/callable'
require 'log_parser/run'

module LogParser
  module CLI
    class Run
      # This class server as a bridge between command line and the main domain of the program

      include Callable

      def initialize(options)
        @options = options
      end

      def call
        LogParser::Run.(**run_args)
      end

      private

      def run_args
        {
          loaders: [
            *text_file_loaders
          ]
        }
      end

      def text_file_loaders
        return [] unless options.text_files.any?

        require 'log_parser/loaders/text_file_loader'
        options.text_files.map { |file_path| LogParser::Loaders::TextFileLoader.(file_path) }
      end

      attr_reader :options
    end
  end
end
