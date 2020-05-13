module LogParser
  module Stats
    class VisitCount
      def initialize
        @cache = Hash.new { |h,k| h[k] = 0 }
      end

      def record(path, _ip)
        cache[path] += 1
      end

      def result
        cache.to_a.sort_by(&:last)
      end

      private

      attr_reader :cache
    end
  end
end