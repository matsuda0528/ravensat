module Ravensat
  class PropVar
    attr_accessor :value

    def initialize
      @value # => true | false | undef
    end

    # def +@
    #   # unuse?
    #   # return PropLogic object
    #   'this is +@ method'
    # end

    # def -@
    #   # return PropLogic object
    #   'this is -@ method'
    # end

    def ~@
      Ravensat::PropLogic.new [:not, self]
      # return PropLogic object
    end

    def &( object )
      Ravensat::PropLogic.new [:and, self, object.formula]
      # return PropLogic object
    end

    def |( object )
      Ravensat::PropLogic.new [:or, self, object.formula]
      # return PropLogic object
    end

    def formula
      # 付け焼刃メソッド
      self
    end

    # def self
    #   'this is self method'
    # end

  end
end
