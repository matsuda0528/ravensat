module Ravensat
  class VarNode < Node
    attr_accessor :value
    def initialize
      @value
      @children = []
    end

    def ~@
      NotNode.new(self)
    end

    def cnf?
      true
    end
  end
end
