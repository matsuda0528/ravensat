module Ravensat
  class PropLogic
    attr_reader :formula
    attr_reader :name_table

    def initialize( init_formula )
      @formula = init_formula
         # (a | b) & (~a | b) & (a | ~b) & (~a | ~b)

         # [:and,
         #    [:or, a, b],
         #    [:or, [:not, a], b],
         #    [:or, a, [:not, b]],
         #    [:or, [:not, a], [:not, b]]
         # ]
    end

    def to_cnf

    end

    def to_dimacs
      cnf_text = String.new
      tmp_name_table = @formula.flatten.uniq.reject{|e| e.class == Symbol}
      @name_table = tmp_name_table.zip((1..tmp_name_table.size).to_a.map{|e| e.to_s}).to_h

      nr_vars = tmp_name_table.size
      nr_clses = @formula.size - 1
      cnf_header = 'p cnf ' << nr_vars.to_s << ' ' << nr_clses.to_s << "\n"
      # @formula.is_cnf?
      @formula.each do |clause|
        # next if clause.first != :and
        case clause
        when Symbol
          next
        when Array
          case clause.first
          when :or
            clause.each do |literal|
              case literal
              when Symbol
                next
              when Ravensat::PropVar
                cnf_text << @name_table[literal] << ' '
              when Array #&& literal.first == :not
                cnf_text << '-' << @name_table[literal.last] << ' '
              end
            end
          when :not
            cnf_text << '-' << @name_table[clause.last] << ' '
          end
        when Ravensat::PropVar
          cnf_text << @name_table[clause] << ' '
        end
        cnf_text << '0' << "\n"
      end
      cnf_header + cnf_text
    end

    def &( object )
      if @formula.first == :and
        @formula.append object.formula
      else
        @formula = [:and, @formula, object.formula]
      end
      self
      # Ravensat::PropLogic.new [:and, @formula, object]
      # formulaがcnfである前提の実装
      # @formula & other_formula
    end

    def |( object )
      if @formula.first == :or
        @formula.append object.formula
      else
        @formula = [:or, @formula, object.formula]
      end
      self
      # Ravensat::PropLogic.new [:or, @formula, object]
      # 木構造に落とすのが難しそう，実装見送り
      # @formula | other_formula
    end

    # def to_a
    #   @formula.each do |f|
    #     if f.class == PropLogic
    #       f = f.to_a
    #     end
    #   end
    # end
  end
end
