module Ravensat
  dir = File.dirname(__FILE__) + '/ast'

  autoload :Node, dir + '/node.rb'
  autoload :VarNode, dir + '/var_node.rb'
  autoload :OprNode, dir + '/opr_node.rb'
  autoload :AndNode, dir + '/and_node.rb'
  autoload :OrNode, dir + '/or_node.rb'
  autoload :NotNode, dir + '/not_node.rb'
  autoload :InitialNode, dir + '/initial_node.rb'
end
