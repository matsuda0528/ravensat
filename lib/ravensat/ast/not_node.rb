module Ravensat
  class NotNode < OprNode
    def ~@
      @children.first
    end
  end
end
