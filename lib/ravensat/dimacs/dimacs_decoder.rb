module Ravensat
  class DimacsDecoder
    def decode(model, name_table)
      inverted_name_table = name_table.invert
      case model.first
      when "SAT"
        model.last.split.each do |e|
          if e == '0'
            next
          elsif e[0] == "-"
            index = e.slice(1..-1)
            inverted_name_table[index].value = false
          else
            index = e
            inverted_name_table[index].value = true
          end
        end
        true
      when "UNSAT"
        false
      end
    end
  end
end
