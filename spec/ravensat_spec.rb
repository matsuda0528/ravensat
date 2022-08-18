# frozen_string_literal: true

RSpec.describe Ravensat do
  let(:solver) { Ravensat::Solver.new }
  let(:encoder) {Ravensat::DimacsEncoder.new}
  let(:p1) { Ravensat::VarNode.new }
  let(:p2) { Ravensat::VarNode.new }
  let(:p3) { Ravensat::VarNode.new }

  it "solves for CNF-SAT" do
    formula = ~p1 & (p1 | p2) & (p1 | p3)
    solver.solve formula
    expect(p1.result).to eq false
    expect(p2.result).to eq true
    expect(p3.result).to eq true
  end

  it "determines CNF" do
    formula = (p1 | p2 | ~p3) & (~p1 | ~p2) & p1 & p3
    expect(formula.cnf?).to eq true
  end

  it "determines CNF" do
    formula = (p1 & p2 & ~p3) | (~p1 & ~p2) | p1 | p3
    expect(formula.cnf?).to eq false
  end

  it "determines CNF" do
    formula = p1 & p2 | p3 | ~p1 & ~p2 | ~p3
    expect(formula.cnf?).to eq false
  end

  it "generates DIMACS Format" do
    formula = (p1 | p2 | ~p3) & (~p1 | ~p2) & p1 & p2
    expect(encoder.to_dimacs formula).to eq "p cnf 3 4\n1 2 -3 0\n-1 -2 0\n1 0\n2 0\n"
  end
end
