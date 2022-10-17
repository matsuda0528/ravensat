module Ravensat
  class OrNode < OprNode
    def |(object)
      raise TypeError.new("#{object.class} can't be coerced into Ravensat::Node") unless object.is_a? Node
      return self if object.is_a? NilNode

      @children.append object
      self
    end

    def cnf?
      return false if @children.any?{|node| node.is_a? AndNode}
      @children.map(&:cnf?).reduce(:&)
    end

    def to_dimacs
      " "
    end

    def eval
      @children.map(&:eval).reduce(:|)
    end
  end
end
