module Ravensat
  class DimacsEncoder
    attr_reader :name_table
    def initialize
      @name_table = {}
    end

    def to_dimacs(formula)
      dimacs_header = "p cnf #{formula.vars_size} #{formula.clauses_size}\n"
      dimacs_body = ""
      return nil unless formula.cnf?

      set_dimacs_name(formula)

      formula.each_by_descriptive do |node|
        dimacs_body << node.to_dimacs
      end

      dimacs_header + dimacs_body
    end

    def set_dimacs_name(formula)
      formula.vars.each_with_index do |node, i|
        node.dimacs_name = (i+1).to_s
      end
    end
  end
end
