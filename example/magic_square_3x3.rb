require 'ravensat'

# | ---- | ---- | ---- |
# |  X1  |  X2  |  X3  |
# |  X4  |  X5  |  X6  |
# |  X7  |  X8  |  X9  |
# | ---- | ---- | ---- |

x1 = Array.new(9){ Ravensat::PropVar.new }
x2 = Array.new(9){ Ravensat::PropVar.new }
x3 = Array.new(9){ Ravensat::PropVar.new }
x4 = Array.new(9){ Ravensat::PropVar.new }
x5 = Array.new(9){ Ravensat::PropVar.new }
x6 = Array.new(9){ Ravensat::PropVar.new }
x7 = Array.new(9){ Ravensat::PropVar.new }
x8 = Array.new(9){ Ravensat::PropVar.new }
x9 = Array.new(9){ Ravensat::PropVar.new }

logic = x1[0]

# all different x1 ~ x9
9.times do |i|
  logic &= Ravensat::RavenClaw.alo [x1[i], x2[i], x3[i], x4[i], x5[i], x6[i], x7[i], x8[i], x9[i]]
  logic &= Ravensat::RavenClaw.amo [x1[i], x2[i], x3[i], x4[i], x5[i], x6[i], x7[i], x8[i], x9[i]]
end

solver = Ravensat::Solver.new
solver.solve logic

binding.irb
