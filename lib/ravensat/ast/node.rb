module Ravensat
  class Node
    include Enumerable

    attr_reader :children
    def initialize
      @children = []
    end

    def each_by_descriptive
      node_stack = [[self, self.children.clone]] #[[parent, children], ...]

      until node_stack.empty?
        current_parent, current_children = node_stack.pop
        current_node = current_children.shift

        case current_node
        when AndNode
          node_stack.push [current_parent, current_children.clone]
          node_stack.push [current_node, current_node.children.clone]
        when OrNode
          node_stack.push [current_parent, current_children.clone]
          node_stack.push [current_node, current_node.children.clone]
        when NotNode
          yield(current_node)
          yield(current_node.children.first)

          if current_children.empty?
            yield(node_stack.last.first)
          else
            yield(current_parent)
            node_stack.push [current_parent, current_children.clone]
          end
        when VarNode, Extension::BooleanVariable
          yield(current_node)

          if current_children.empty?
            yield(node_stack.last.first)
          else
            yield(current_parent)
            node_stack.push [current_parent, current_children.clone]
          end
        end
      end
    end

    def each
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
