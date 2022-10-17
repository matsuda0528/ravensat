module Ravensat
  class NotNode < OprNode
    def ~@
      @children.first
    end

    def to_dimacs
      "-"
    end

    def eval
      @children.map(&:eval).first ^ true
    end
  end
end
