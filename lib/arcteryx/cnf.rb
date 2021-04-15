module Arcteryx
  class CNF
    def initialize(formula=[],truth={})
      @formula = formula
      @truth_assignment = truth
    end

    def parse(file_path)
      header = ""; clauses = [];
      File.open(file_path,"r") do |f|
        header = f.readline
        clauses = f.readlines
      end
      header.split[2].to_i.times do |i|
        @truth_assignment["#{i+1}".to_sym] = nil
      end
      clauses.each do |e|
        clause = e.split.map{|i| i.to_i}
        clause.pop
        @formula.append clause
      end
    end

    def unit_propagation
      while !self.exist_empty_clause? and l = self.find_unit_clause
        @truth_assignment["#{l.abs}".to_sym] = l > 0
        self.simplify(l)
      end
    end

    def simplify(l)
      @formula.delete_if do |cls|
        cls.include?(l)
      end
      @formula.map{|cls| if cls.include?(-1*l) then cls.delete(-1*l) end}
    end

    def empty?
      @formula.empty?
    end

    def find_unit_clause
      @formula.map{|cls| if cls.size == 1 then return cls.first end}
      return false
    end

    def exist_empty_clause?
      @formula.map{|cls| if cls.empty? then return true end}
      return false
    end

    def choose_variable
      @truth_assignment.map{|key,value| if value == nil then return key.to_s.to_i end}
      return false
    end

    def append l
      @formula.append [l] if l
      return self
    end

    def deep_dup
      tmp_formula = Marshal.load(Marshal.dump(@formula))
      tmp_truth = Marshal.load(Marshal.dump(@truth_assignment))
      CNF.new(tmp_formula,tmp_truth)
    end

    def result
      str = ""
      @truth_assignment.map{|key,value| unless value then str<<"-" end; str<<key.to_s+" "}
      return str << "0"
    end
  end
end
