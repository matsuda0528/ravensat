require 'tempfile'

module Ravensat
  class Solver
    attr_accessor :name
    def initialize( default_solver_name = "arcteryx" )
      @name = default_solver_name
      # @cnf = Array.new
      # @nr_vars
      # @nr_clses
    end

    # def <<( clause )
    #   'this is << method'
    # end

    def solve( cnf )
      @input_file = Tempfile.open(["ravensat",".cnf"])
      @output_file = Tempfile.open(["ravensat",".mdl"])

      @input_file.write cnf.to_dimacs
      @input_file.flush

      case @name
      when "arcteryx"
        Arcteryx.solve(@input_file.to_path, @output_file.to_path)
      else
        system("#{@name} #{@input_file.to_path} #{@output_file.to_path}")
      end

      model = @output_file.read.split("\n")

      case model.first
      when "SAT"
        model.last.split.each do |e|
          next if e == '0'
          cnf.name_table.find{|key,value| value == e.to_i.abs.to_s}.first.value = !e.start_with?('-')
        end
        Arcteryx::SAT
      when "UNSAT"
        Arcteryx::UNSAT
      end
    end

  end
end
