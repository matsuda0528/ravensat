require 'benchmark'
module Ravensat
  class DimacsEncoder
    attr_reader :name_table
    def initialize
      @name_table = {}
    end

    def to_dimacs(formula)
      dimacs_header = "p cnf #{formula.vars_size} #{formula.clauses_size}\n"
      dimacs_body = ""
      Benchmark.bm 20 do |r|
        r.report "cnf? method" do
          return nil unless formula.cnf?
        end

        r.report "create table method" do
          set_dimacs_name(formula)
        end

        r.report "formula each" do
          formula.each do |node|
            dimacs_body << node.to_dimacs
            # case node
            # when AndNode then dimacs_body << " 0\n"
            # when OrNode then dimacs_body << " "
            # when NotNode then dimacs_body << "-"
            # when VarNode then dimacs_body << @name_table[node]
            # end
          end
          dimacs_body << " 0\n"
        end

      end
      dimacs_header + dimacs_body
    end

    def set_dimacs_name(formula)
      # @name_table = formula.vars.zip((1..formula.vars.size).map(&:to_s)).to_h
      formula.vars.each_with_index do |node, i|
        node.dimacs_name = (i+1).to_s
      end
    end
  end
end
