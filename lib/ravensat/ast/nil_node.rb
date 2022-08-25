module Ravensat
  class NilNode < Node
    def initialize
      @children = []
    end

    def &(object)
      raise TypeError.new("#{object.class} can't be coerced into Ravensat::Node") unless object.is_a? Node
      object
    end

    def |(object)
      raise TypeError.new("#{object.class} can't be coerced into Ravensat::Node") unless object.is_a? Node
      object
    end
  end
end
