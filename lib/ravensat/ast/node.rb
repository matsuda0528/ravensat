module Ravensat
  class Node
    include Enumerable

    attr_reader :children
    def initialize
      @children = []
    end

    # def each
    #   yield(self)
    #   @children.each do |child|
    #     child.each {|c| yield(c)}
    #   end
    # end

    def each
      case self
      when AndNode, OrNode
        @children.first.each{|c| yield(c)}
        yield(self)
        @children.last.each{|c| yield(c)}
      when NotNode
        yield(self)
        @children.first.each{|c| yield(c)}
      when VarNode
        yield(self)
      end
    end

    def each_speed
      node_stack = [self]

      until node_stack.empty?
      end
    end

    def each_rubytree
      return to_enum unless block_given?
      node_stack = [self]

      until node_stack.empty?
        current_node = node_stack.shift
        next unless current_node

        yield current_node

        node_stack = node_stack.concat(current_node.children)
      end

      self if block_given?
    end

    def each_naive
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

    def to_s
      self.class.name
    end

    def to_dimacs
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
