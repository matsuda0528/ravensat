# frozen_string_literal: true

require_relative "ravensat/version"

module Ravensat
  ravensat = File.dirname(__FILE__) + '/ravensat'
  ast = File.dirname(__FILE__) + '/ravensat/ast'
  arcteryx = File.dirname(__FILE__) + '/arcteryx'

  require_relative ravensat + "/ast.rb"
  require_relative ravensat + "/dimacs.rb"

  autoload :Solver, ravensat + '/solver.rb'
  autoload :Claw, ravensat + '/claw.rb'
  autoload :Extension, ravensat + '/extension.rb'

  autoload :Arcteryx, arcteryx + '/arcteryx.rb'
end
