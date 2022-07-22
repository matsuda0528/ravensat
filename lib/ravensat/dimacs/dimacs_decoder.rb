module Ravensat
  class DimacsDecoder
    def decode(model, cnf)
      prop_vars = cnf.vars
      case model.first
      when "SAT"
        model.last.split.each_with_index do |e,i|
          break if e == '0'
          var = prop_vars[i]
          var.value = !(e[0] == '-')
        end
        true
      when "UNSAT"
        false
      end
    end
  end
end
