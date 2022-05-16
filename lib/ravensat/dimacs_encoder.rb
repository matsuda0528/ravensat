module Ravensat
  class DimacsEncoder
    def initialize
    end

    def to_dimacs(formula)
      return nil unless formula.cnf?

      dimacs_header = "p cnf #{formula.vars_size} #{formula.clauses_size}"
      dimacs_body = ""
      create_table(formula)
      formula.each do |node|
        case node
        when AndNode
        when OrNode then dimacs_body << "\n"
        when NotNode then dimacs_body << "-"
        when VarNode then dimacs_body << @name_table[node] << " "
        end
      end

      dimacs_body.gsub!(/\n{2,}/, "\n").gsub!(/\n/, "0\n") << '0'

      dimacs_header + dimacs_body
    end

    def create_table(formula)
      @name_table = formula.vars.zip((1..formula.vars.size).map(&:to_s)).to_h
    end
  end
end
