require 'log_parser/helpers/callable'
require 'log_parser/helpers/lazy_registry'
require 'log_parser/stats/visit_count'
require 'log_parser/run'

module LogParser
  module CLI
    class Run
      # This class server as a bridge between command line and the main domain of the program

      include Callable

      PresenterRegistry = Helpers::LazyRegistry.new.tap do |r|
        r.register 'simple', 'LogParser::CLI::Presenters::Simple', 'log_parser/cli/presenters/simple'
      end

      def initialize(options, out: STDOUT)
        @options = options
        @out = out
      end

      def call
        result = LogParser::Run.(**run_args)
        out << presenter.(result)
        out << "\n\n"
      end

      private

      attr_reader :options, :out


      def run_args
        {
          loaders: text_file_loaders,
          stat: LogParser::Stats::VisitCount.new
        }
      end

      def text_file_loaders
        return [] unless options.text_files.any?

        require 'log_parser/loaders/text_file_loader'
        options.text_files.map { |file_path| LogParser::Loaders::TextFileLoader.(file_path) }
      end

      def presenter
        PresenterRegistry.get('simple')
      end
    end
  end
end
