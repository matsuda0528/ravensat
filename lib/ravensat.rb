# frozen_string_literal: true

require_relative "ravensat/version"

module Ravensat
  ravensat = File.dirname(__FILE__) + '/ravensat'
  ast = File.dirname(__FILE__) + '/ravensat/ast'
  arcteryx = File.dirname(__FILE__) + '/arcteryx'

  autoload :Solver, ravensat + '/solver.rb'
  autoload :DimacsEncoder, ravensat + '/dimacs_encoder.rb'
  autoload :DimacsDecoder, ravensat + '/dimacs_decoder.rb'
  autoload :RavenClaw, ravensat + '/ravenclaw.rb'

  autoload :Node, ast + '/node.rb'
  autoload :VarNode, ast + '/var_node.rb'
  autoload :OprNode, ast + '/opr_node.rb'
  autoload :AndNode, ast + '/and_node.rb'
  autoload :OrNode, ast + '/or_node.rb'
  autoload :NotNode, ast + '/not_node.rb'

  autoload :Arcteryx, arcteryx + '/arcteryx.rb'
end
