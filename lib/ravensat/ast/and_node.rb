module Ravensat
  class AndNode < OprNode
    def &(object)
      raise TypeError.new("#{object.class} can't be coerced into Ravensat::Node") unless object.is_a? Node
      @children.append object
      self
    end

    def to_dimacs
      " 0\n"
    end
  end
end
