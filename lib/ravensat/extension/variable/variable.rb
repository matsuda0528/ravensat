module Ravensat
  module Extension
    class Variable

      attr_reader :name, :args
      def initialize(name, args)
        @name = name
        @args = args
      end

      def is_defined?
        true
      end
    end
  end
end
