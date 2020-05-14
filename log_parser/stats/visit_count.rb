module LogParser
  module Stats
    class VisitCount
      def initialize
        @cache = Hash.new { |hash, path| hash[path] = 0 }
      end

      def record(path, _ip)
        cache[path] += 1
      end

      def result
        cache.sort_by { |_, count| -count }
      end

      private

      attr_reader :cache
    end
  end
end
