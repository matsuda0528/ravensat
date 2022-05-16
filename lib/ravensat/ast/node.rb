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

    def cnf?
      and_node_flag = false
      self.each do |node|
        return false if and_node_flag && node.is_a?(AndNode)
        and_node_flag = true if !(node.is_a? AndNode)
      end
      true
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
