require 'log_parser/helpers/callable'
module LogParser
  class Run
    # This is the main entry point of the program.
    # Options taken:
    #    loaders:  list of data loaders. Each data loader should be enumerator yielding address and ip address of the visit
    include Callable

    attr_reader :loaders

    def initialize(loaders:)
      @loaders = loaders
    end

    def call
    end    
  end
end
