module Ravensat
  dir = File.dirname(__FILE__) + '/dimacs'

  autoload :DimacsEncoder, dir + '/dimacs_encoder.rb'
  autoload :DimacsDecoder, dir + '/dimacs_decoder.rb'
end
