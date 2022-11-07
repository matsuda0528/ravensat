module Ravensat
  module Claw
    def self.at_most_one(bool_vars)
      return Ravensat::NilNode.new if bool_vars.size == 1
      bool_vars.combination(2).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
    end

    def self.at_least_one(bool_vars)
      return Ravensat::NilNode.new if bool_vars.size == 1
      bool_vars.reduce(:|)
    end

    def self.at_most_k(bool_vars, k)
      return Ravensat::NilNode.new if bool_vars.size == 1
      bool_vars.combination(k+1).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
    end

    def self.at_least_k(bool_vars, k)
      return Ravensat::NilNode.new if bool_vars.size == 1
      bool_vars.combination(k-1).map do |e|
        at_least_one(bool_vars - e)
      end.reduce(:&)
    end


    # NOTE: Klieber, W. and Kwon, G.: Efficient CNF Encoding for Selecting 1 from N Objects (2007).
    def self.commander_at_most_one(bool_vars)
      return Ravensat::NilNode.new if bool_vars.size == 1
      # XXX: Operator unknown if bool_vars.size is very small.
      m = bool_vars.size / 2
      commander_variables = []
      formula = Ravensat::InitialNode.new
      bool_vars.each_slice(2) do |g|
        c = Ravensat::VarNode.new
        subset = g << ~c
        formula &= at_most_one(subset)
        formula &= at_least_one(subset)
        commander_variables << c
      end

      if m < 6
        formula &= at_most_one(commander_variables)
      else
        formula &= commander_at_most_one(commander_variables)
      end
    end

    def self.commander_at_most_k(bool_vars, k)
      return Ravensat::NilNode.new if bool_vars.size == 1
      return commander_at_most_one(bool_vars) if k == 1
      group_size = k + 2
      commander_variables = []
      formula = Ravensat::InitialNode.new

      bool_vars.each_slice(group_size) do |g|
        cmds = Array.new(k){Ravensat::VarNode.new}
        subset = g + cmds.map(&:~)
        formula &= at_most_k(subset, k)
        formula &= at_least_k(subset, k)
        cmds.each_cons(2) do |e1, e2|
          formula &= ~e1 | e2
        end
        commander_variables += cmds
      end

      formula &= at_most_k(commander_variables, k)
    end

    def self.exactly_one(bool_vars)
      formula = Ravensat::InitialNode.new
      formula &= commander_at_most_one(bool_vars)
      formula &= at_least_one(bool_vars)
    end

    def self.exactly_k(bool_vars, k)
      formula = Ravensat::InitialNode.new
      formula &= commander_at_most_k(bool_vars, k)
      formula &= at_least_k(bool_vars, k)
    end

    def self.all_different(*int_vars)
      int_vars.combination(2).map do |int_var|
        int_var.reduce(:!=)
      end.reduce(:&)
    end

    def self.all_only_one(*int_vars)
      int_vars.map(&:only_one).reduce(:&)
    end
  end
end
