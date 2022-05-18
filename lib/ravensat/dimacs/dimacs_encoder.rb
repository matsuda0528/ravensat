module Ravensat
  class DimacsEncoder
    attr_reader :name_table
    def initialize
      @name_table = {}
    end

    def to_dimacs(formula)
      return nil unless formula.cnf?

      dimacs_header = "p cnf #{formula.vars_size} #{formula.clauses_size}\n"
      dimacs_body = ""
      create_table(formula)
      formula.each_with_clause do |node|
        case node
        when AndNode then dimacs_body << " 0\n"
        when OrNode then dimacs_body << " "
        when NotNode then dimacs_body << "-"
        when VarNode then dimacs_body << @name_table[node]
        end
      end
      dimacs_body << " 0\n"

      dimacs_header + dimacs_body
    end

    def create_table(formula)
      @name_table = formula.vars.zip((1..formula.vars.size).map(&:to_s)).to_h
    end
  end
end
