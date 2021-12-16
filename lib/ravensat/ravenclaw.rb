module Ravensat
  class RavenClaw
    def initialize; end

    def self.alo(prop_vars)
      prop_vars.reduce(:|)
    end

    def self.amo(prop_vars)
      prop_vars.combination(2).map do |e|
        e.map(&:~@).reduce(:|)
      end.reduce(:&)
    end
  end
end
