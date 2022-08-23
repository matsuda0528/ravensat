module Ravensat
  module Claw
    def self.alo(bool_vars)
      return bool_vars.first if bool_vars.size == 1
      bool_vars.reduce(:|)
    end

    def self.at_most_k(bool_vars, k)
      return bool_vars.first if bool_vars.size == 1
      bool_vars.combination(k+1).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
    end

    def self.at_least_k(bool_vars, k)
      return bool_vars.first if bool_vars.size == 1
      bool_vars.combination(k-1).map do |e|
        alo(bool_vars - e)
      end.reduce(:&)
    end

    def self.pairwise_amo(bool_vars)
      return bool_vars.first if bool_vars.size == 1
      bool_vars.combination(2).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
    end

    # NOTE: Klieber, W. and Kwon, G.: Efficient CNF Encoding for Selecting 1 from N Objects (2007).
    def self.commander_amo(bool_vars)
      return bool_vars.first if bool_vars.size == 1
      # XXX: Operator unknown if bool_vars.size is very small.
      m = bool_vars.size / 2
      commander_variables = []
      formula = Ravensat::InitialNode.new
      bool_vars.each_slice(2) do |g|
        c = Ravensat::VarNode.new
        subset = g << ~c
        formula &= pairwise_amo(subset)
        formula &= alo(subset)
        commander_variables << c
      end

      if m < 6
        formula &= pairwise_amo(commander_variables)
      else
        formula &= commander_amo(commander_variables)
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
