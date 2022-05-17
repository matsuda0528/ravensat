require 'forwardable'

module Ravensat
  module Extension
    class BooleanVariable < Variable
      extend Forwardable
      delegate Node.public_instance_methods(false) => :@var_node
      delegate OprNode.public_instance_methods(false) => :@var_node
      delegate VarNode.public_instance_methods(false) => :@var_node

      def initialize(name, args)
        super
        @var_node = VarNode.new
      end
    end
  end
end
