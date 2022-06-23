module Ravensat
  class AndNode < OprNode
    def &(object)
      @children.append object
      self
    end

    def to_dimacs
      " 0\n"
    end
  end
end
