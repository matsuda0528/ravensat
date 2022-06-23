module Ravensat
  class DimacsDecoder
    def decode(model, cnf)
      # inverted_name_table = name_table.invert
      prop_vars = cnf.vars
      case model.first
      when "SAT"
        model.last.split.each do |e|
          if e == '0'
            next
          elsif e[0] == "-"
            dimacs_name = e.slice(1..-1)
            var = prop_vars.find{|i| i.dimacs_name == dimacs_name}
            var.value = false
          else
            dimacs_name = e
            var = prop_vars.find{|i| i.dimacs_name == dimacs_name}
            var.value = true
          end
        end
        true
      when "UNSAT"
        false
      end
    end
  end
end
