require 'log_parser/helpers/callable'

module LogParser
  module Loaders
    class TextFileLoader
      include Callable

      def initialize(file_path)
        @file_path = file_path
      end

      def call
        Enumerator.new do |y|
          file = File.open(file_path, 'r')
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
