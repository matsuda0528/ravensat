require 'tempfile'

module Ravensat
  class Solver
    attr_accessor :name
    def initialize( default_solver_name = "arcteryx" )
      @name = default_solver_name
    end

    def solve( cnf )
      encoder = DimacsEncoder.new
      @input_file = Tempfile.open(["ravensat",".cnf"])
      @output_file = Tempfile.open(["ravensat",".mdl"])

      @input_file.write encoder.to_dimacs(cnf)
      @input_file.flush

      case @name
      when "arcteryx"
        Arcteryx.solve(@input_file.to_path, @output_file.to_path)
      else
        system("#{@name} #{@input_file.to_path} #{@output_file.to_path}")
      end

      decoder = DimacsDecoder.new
      model = @output_file.read.split("\n")
      decoder.decode(model, cnf)
    end

  end
end
