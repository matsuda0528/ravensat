module Ravensat
  module Extension
    class IntegerVariable < Variable
      def initialize(name, args)
        super
        return unless args.first.is_a? Range
        @var_nodes = args.first.zip(Array.new(args.first.size){Ravensat::VarNode.new}).to_h
      end
    end
  end
end
