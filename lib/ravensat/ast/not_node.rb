module Ravensat
  class NotNode < OprNode
    def ~@
      @children.first
    end

    def to_dimacs
      "-"
    end
  end
end
