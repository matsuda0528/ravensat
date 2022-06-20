module Ravensat
  class VarNode < Node
    attr_accessor :value
    attr_writer :dimacs_name
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
  end
end
