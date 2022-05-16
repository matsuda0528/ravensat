module Ravensat
  class OrNode < OprNode
    def cnf?
      return false if @children.any?{|node| node.is_a? AndNode}
      @children.map(&:cnf?).reduce(:&)
    end
  end
end
