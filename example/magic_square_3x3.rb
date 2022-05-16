require 'bundler/setup'
require 'ravensat'
require 'pry'

# | ---- | ---- | ---- |
# |  X1  |  X2  |  X3  |
# |  X4  |  X5  |  X6  |
# |  X7  |  X8  |  X9  |
# | ---- | ---- | ---- |

x1 = Array.new(9){ Ravensat::VarNode.new }
x2 = Array.new(9){ Ravensat::VarNode.new }
x3 = Array.new(9){ Ravensat::VarNode.new }
x4 = Array.new(9){ Ravensat::VarNode.new }
x5 = Array.new(9){ Ravensat::VarNode.new }
x6 = Array.new(9){ Ravensat::VarNode.new }
x7 = Array.new(9){ Ravensat::VarNode.new }
x8 = Array.new(9){ Ravensat::VarNode.new }
x9 = Array.new(9){ Ravensat::VarNode.new }
x = [x1, x2, x3, x4, x5, x6, x7, x8, x9]

logic = x1[4]

# one square, one number
9.times do |i|
  logic &= Ravensat::RavenClaw.alo [x[i][0], x[i][1], x[i][2], x[i][3], x[i][4], x[i][5], x[i][6], x[i][7], x[i][8]]
  logic &= Ravensat::RavenClaw.amo [x[i][0], x[i][1], x[i][2], x[i][3], x[i][4], x[i][5], x[i][6], x[i][7], x[i][8]]
end

# x1 ~ x9 are all different numbers
9.times do |i|
  logic &= Ravensat::RavenClaw.alo [x[0][i], x[1][i], x[2][i], x[3][i], x[4][i], x[5][i], x[6][i], x[7][i], x[8][i]]
  logic &= Ravensat::RavenClaw.amo [x[0][i], x[1][i], x[2][i], x[3][i], x[4][i], x[5][i], x[6][i], x[7][i], x[8][i]]
end

# TODO: generate constraint that sum to 15 in a row
# sum to 15 in a row

solver = Ravensat::Solver.new
solver.solve logic

puts <<~"MAGIC_SQUARE"
| --- | --- | --- |
|  #{x1.index{|x| x.value} + 1}  |  #{x2.index{|x| x.value} + 1}  |  #{x3.index{|x| x.value} + 1}  |
|  #{x4.index{|x| x.value} + 1}  |  #{x5.index{|x| x.value} + 1}  |  #{x6.index{|x| x.value} + 1}  |
|  #{x7.index{|x| x.value} + 1}  |  #{x8.index{|x| x.value} + 1}  |  #{x9.index{|x| x.value} + 1}  |
| --- | --- | --- |
MAGIC_SQUARE
