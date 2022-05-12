module Ravensat
  class Node
    include Enumerable

    def initialize
      @children = []
    end

    def each
      yield(self)
      @children.each do |child|
        child.each {|c| yield(c)}
      end
    end

    def &(object)
      AndNode.new(self, object)
    end

    def |(object)
      OrNode.new(self, object)
    end

    # def tree_text
    #   self.each do |child|
    #     child.to_s
    #   end
    # end

    def to_s
      self.class.name
    end
  end
end
