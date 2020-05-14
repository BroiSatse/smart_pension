require 'set'

module LogParser
  module Stats
    class UniqueVisitCount
      def initialize
        @cache = Hash.new { |hash, path| hash[path] = CacheEntry.new }
      end

      def record(path, ip)
        cache[path].record(ip)
      end

      def result
        cache
          .transform_values(&:unique_visits)
          .sort_by { |_path, count| -count }
      end

      private

      attr_reader :cache

      class CacheEntry
        def initialize
          @ips = Set.new
        end

        def record(ip)
          ips << ip
        end

        def unique_visits
          ips.size
        end

        private

        attr_reader :ips
      end
    end
  end
end
