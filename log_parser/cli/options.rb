module LogParser
  module CLI
    class Options
      attr_reader :files

      def initialize
        @files = []
      end

      def self.parse!(args)
        options = self.new

        parser = OptionParser.new do |p|
          p.banner = 'Usage: parse_log [options]'

          p.on('-fFILE') do |file|
            options.files << file
          end
        end

        parser.parse!(args)
        options
      end
    end
  end
end
