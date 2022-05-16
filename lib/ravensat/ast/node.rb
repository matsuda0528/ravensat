module Ravensat
  class Node
    include Enumerable

    attr_reader :children
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

    def cnf?
      @children.map(&:cnf?).reduce(:&)
    end

    def vars
      self.select{|node| node.is_a? VarNode}.uniq
    end

    def vars_size
      self.vars.size
    end

    def clauses_size
      self.count{|node| node.is_a? AndNode} + 1
    end
  end
end
