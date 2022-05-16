module Ravensat
  class VarNode < Node
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
