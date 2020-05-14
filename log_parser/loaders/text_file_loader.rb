require 'log_parser/helpers/callable'
require 'log_parser/loaders/error'

module LogParser
  module Loaders
    class TextFileLoader
      include Callable

      def initialize(file_path)
        @file_path = file_path
      end

      def call
        Enumerator.new do |y|
          begin
            file = File.open(file_path, 'r')
          rescue Errno::ENOENT
            raise Error, "Failed to open file `#{file_path}`"
          end

          file.each
            .map { |line| line.chop.split(' ') }
            .each { |address, ip| y << [address, ip] }
          file.close
        end
      end

      private

      attr_reader :file_path
    end
  end
end
