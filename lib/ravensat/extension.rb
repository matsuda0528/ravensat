module Ravensat
  module Extension
    dir = File.dirname(__FILE__) + '/extension'

    autoload :Domain, dir + '/domain.rb'
    autoload :Variable, dir + '/variable/variable.rb'
    autoload :BooleanVariable, dir + '/variable/boolean_variable.rb'
    autoload :IntegerVariable, dir + '/variable/integer_variable.rb'
    autoload :UndefinedVariable, dir + '/variable/undefined_variable.rb'

    extend Domain
  end
end
