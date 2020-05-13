require 'log_parser/helpers/callable'
module LogParser
  class Run
    # This is the main entry point of the program.
    # Options taken:
    #    loaders:  list of data loaders. Each data loader should be enumerator yielding address and
    #              ip address of the visit
    include Callable

    def initialize(loaders:, stat:)
      @loaders = loaders
      @stat = stat
    end

    def call
      each_log_entry do |path, ip|
        stat.record path, ip
      end
      stat.result
    end

    private

    # TODO: This should be handled by LoadManager
    def each_log_entry
      loaders.each do |loader|
        loader.each do |path, ip|
          yield path, ip
        end
      end
    end

    attr_reader :loaders, :stat
  end
end
