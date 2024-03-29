module Ravensat
  class AndNode < OprNode
    def &(object)
      raise TypeError.new("#{object.class} can't be coerced into Ravensat::Node") unless object.is_a? Node
      return self if object.is_a? NilNode

      @children.append object
      self
    end

    def to_dimacs
      " 0\n"
    end

    def eval
      @children.map(&:eval).reduce(:&)
    end
  end
end
