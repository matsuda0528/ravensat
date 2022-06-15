module Ravensat
  module Claw
    def self.alo(bool_vars)
      bool_vars.reduce(:|)
    end

    def self.pairwise_amo(bool_vars)
      bool_vars.combination(2).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
    end

    def self.commander_amo(bool_vars)
      m = bool_vars.size / 2
      introductory_variables = []
      formula = Ravensat::InitialNode.new
      bool_vars.each_slice(2) do |e|
        c = Ravensat::VarNode.new
        subset = e << ~c
        formula &= pairwise_amo(subset)
        formula &= alo(subset)
        introductory_variables << c
      end

      if m < 6
        formula &= pairwise_amo(introductory_variables)
      else
        formula &= commander_amo(introductory_variables)
      end
    end

    def self.all_different(*int_vars)
      int_vars.combination(2).map do |int_var|
        int_var.reduce(:!=)
      end.reduce(:&)
    end

    def self.all_only_one(*int_vars)
      int_vars.map(&:only_one).reduce(:&)
    end

    # alias :amo :pairwise_amo
  end
end
