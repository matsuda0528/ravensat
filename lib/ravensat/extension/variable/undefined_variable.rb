module Ravensat
  module Extension
    class UndefinedVariable < Variable
      def is_defined?
        false
      end
    end
  end
end
