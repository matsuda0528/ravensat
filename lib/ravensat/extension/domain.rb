module Ravensat
  module Extension
    module Domain
      LOCAL_VARIABLE_TABLE = {}
      def int(*vars)
        vars.each do |var|
          next if var.is_defined?
          LOCAL_VARIABLE_TABLE[var.name] = Ravensat::Extension::IntegerVariable.new(var.name, var.args)
        end
      end

      def bool(*vars)
        vars.each do |var|
          next if var.is_defined?
          LOCAL_VARIABLE_TABLE[var.name] = Ravensat::Extension::BooleanVariable.new(var.name, var.args)
        end
      end

      def method_missing(name, *args)
        LOCAL_VARIABLE_TABLE[name] || UndefinedVariable.new(name, args)
      end
    end
  end
end
