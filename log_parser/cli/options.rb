require 'optparse'

module LogParser
  module CLI
    class Options
      # This class is responsible for parsing and storing comand line options
      # without any domain-specific operations
      attr_reader :text_files
      attr_accessor :unique
      attr_accessor :pretty

      def initialize
        @text_files = []
        @unique = false
        @pretty = false
      end

      def self.parse!(args)
        options = self.new

        parser = OptionParser.new do |p|
          p.banner = 'Usage: parse_log [options]'

          p.on('-f FILE', 'Text file containing server log to be parsed') do |file|
            options.text_files << file
          end

          p.on('--unique', 'Displays statistics for unique vists') do
            options.unique = true
          end

          p.on('--pretty', 'Formats data in more human-friendly manner') do
            options.pretty = true
          end
        end

        parser.parse!(args)
        options
      end
    end
  end
end
