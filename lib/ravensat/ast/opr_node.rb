module Ravensat
  class OprNode < Node
    def initialize(*nodes)
      @children = nodes
    end
  end
end
