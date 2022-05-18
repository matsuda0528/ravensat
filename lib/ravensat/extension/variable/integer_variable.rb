module Ravensat
  module Extension
    class IntegerVariable < Variable

      attr_reader :var_nodes
      def initialize(name, args)
        super
        return unless args.first.is_a? Range
        @var_nodes = args.first.zip(Array.new(args.first.size){Ravensat::VarNode.new}).to_h
      end

      def ==(object)
        case object
        when Integer
          return @var_nodes[object]
        when IntegerVariable
          result_formula = Ravensat::InitialNode.new
          duplicated_keys = self.var_nodes.keys & object.var_nodes.keys

          [self.var_nodes, object.var_nodes].repeated_permutation(duplicated_keys.size) do |var_nodes|
            result_formula &= Ravensat::RavenClaw.alo(var_nodes.zip(duplicated_keys).map{|arr| arr.first[arr.last]})
          end
          return result_formula
        else
          raise ArgumentError
        end
      end

      def only_one
        result_formula = Ravensat::InitialNode.new
        result_formula &= Ravensat::RavenClaw.alo @var_nodes.values
        result_formula &= Ravensat::RavenClaw.amo @var_nodes.values
        result_formula
      end
    end
  end
end
