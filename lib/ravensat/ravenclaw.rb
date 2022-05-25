module Ravensat
  module RavenClaw
    def self.alo(bool_vars)
      bool_vars.reduce(:|)
    end

    def self.amo(bool_vars)
      bool_vars.combination(2).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
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
