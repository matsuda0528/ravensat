# frozen_string_literal: true

RSpec.describe Ravensat do
  let(:solver) { Ravensat::Solver.new }
  let(:p1) { Ravensat::VarNode.new }
  let(:p2) { Ravensat::VarNode.new }
  let(:p3) { Ravensat::VarNode.new }

  it "has a version number" do
    expect(Ravensat::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(false)
  end

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
end
