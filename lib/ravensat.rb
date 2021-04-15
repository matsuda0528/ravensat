# frozen_string_literal: true

require_relative "ravensat/version"

module Ravensat
  ravensat = File.dirname(__FILE__) + '/ravensat'
  arcteryx = File.dirname(__FILE__) + '/arcteryx'

  autoload :Solver, ravensat + '/solver.rb'
  autoload :PropVar, ravensat + '/prop_var.rb'
  autoload :PropLogic, ravensat + '/prop_logic.rb'

  autoload :Arcteryx, arcteryx + '/arcteryx.rb'
end
