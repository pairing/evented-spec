module EventedSpec
  module SpecHelper
    # Represents example running inside some type of event loop
    class EventedExample
      # Create new evented example
      def initialize(opts, example_group_instance, &block)
        @opts, @example_group_instance, @block = opts, example_group_instance, block
      end

      # Called from #run_event_loop when event loop is stopped,
      # but before the example returns.
      # Descendant classes may redefine to clean up type-specific state.
      #
      def finish_example
        raise @spec_exception if @spec_exception
      end

      # Run the example
      # @override
      def run
        raise NotImplementedError, "you should implement #run in #{self.class.name}"
      end

      # Sets timeout for currently running example
      # @override
      def timeout(spec_timeout)
        raise NotImplementedError, "you should implement #timeout in #{self.class.name}"
      end

      # Breaks the event loop and finishes the spec.
      # @override
      def done(delay=nil, &block)
        raise NotImplementedError, "you should implement #done method in #{self.class.name}"
      end

      # Override this method in your descendants
      # @note delay may be nil, implying you need to execute the block immediately.
      # @override
      def delayed(delay = nil, &block)
        raise NotImplementedError, "you should implement #delayed method in #{self.class.name}"
      end # delayed(delay, &block)
    end # class EventedExample
  end # module SpecHelper
end # module AMQP

require 'evented-spec/evented_example/em_example'
require 'evented-spec/evented_example/amqp_example'