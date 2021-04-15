require_relative './cnf.rb'
module Arcteryx
  SAT = true
  UNSAT = false

  def DPLL(cnf)
    if cnf.empty? then return SAT end
    cnf.unit_propagation
    if cnf.exist_empty_clause? then return UNSAT end
    x = cnf.choose_variable
    dup_cnf = cnf.deep_dup
    return DPLL(cnf.append x) || DPLL(dup_cnf.append -1*x)
  end

  def solve( input_file, output_file = nil )
    cnf = Arcteryx::CNF.new
    cnf.parse(input_file)
    case DPLL(cnf)
    when SAT
      if output_file
        File.open(output_file,"w") do |f|
          f.write("SAT\n"+cnf.result)
        end
      else
        puts "SAT"
        puts cnf.result
      end
    when UNSAT
      if output_file
        File.open(output_file,"w") do |f|
          f.write("UNSAT")
        end
      else
        puts "UNSAT"
      end
    end
  end
  module_function :solve
  module_function :DPLL
end
