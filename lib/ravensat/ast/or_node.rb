module Ravensat
  class OrNode < OprNode
    def |(object)
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
  end
end
