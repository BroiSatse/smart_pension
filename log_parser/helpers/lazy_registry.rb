module LogParser
  module Helpers
    class LazyRegistry
      Entry = Struct.new(:const_name, :file_path)

      def initialize
        @registry = {}
      end

      def register(key, const_name, file_path)
        registry[key.to_sym] = Entry.new(const_name, file_path)
      end

      def get(key)
        return unless entry = registry[key.to_sym]
        require entry.file_path
        entry.const_name.split('::').inject(Object) { |mod, part| mod.const_get(part) }
      end

      private

      attr_reader :registry
    end
  end
end
