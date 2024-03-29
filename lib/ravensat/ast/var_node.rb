module Ravensat
  class VarNode < Node
    attr_accessor :value, :dimacs_name
    def initialize
      @value
      @children = []
      @dimacs_name
    end

    def ~@
      NotNode.new(self)
    end

    def cnf?
      true
    end

    def result
      @value
    end

    def to_dimacs
      @dimacs_name
    end

    def eval
      @value
    end
  end
end
