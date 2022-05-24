# Ravensat

[![Ruby](https://github.com/matsuda0528/ravensat/actions/workflows/main.yml/badge.svg)](https://github.com/matsuda0528/ravensat/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/ravensat.svg)](https://badge.fury.io/rb/ravensat)
[![LICENSE](https://img.shields.io/github/license/matsuda0528/ravensat)](https://opensource.org/licenses/MIT)

Ravensat is an interface to SAT solver in Ruby.

In order to use Ravensat, you need to install SAT solver.
If you do not install SAT solver, it will use the one bundled in the gem.

About [SAT](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem), [SAT solver](https://en.wikipedia.org/wiki/SAT_solver)

## Description
To solve SAT, we usually use SAT solver.
Now, let's solve the following SAT with SAT solver.
<p align="center">
<img src="https://latex.codecogs.com/svg.image?\inline&space;\large&space;\bg{white}(1&space;\lor&space;\lnot&space;5&space;\lor&space;4)&space;\land&space;(\lnot&space;1&space;\lor&space;5&space;\lor&space;3&space;\lor&space;4)&space;\land&space;(\lnot&space;3&space;\lor&space;\lnot&space;4)" style="background-color:white;"/>
</p>

Most SAT solvers are input in [DIMACS Format](https://www.cs.utexas.edu/users/moore/acl2/manuals/current/manual/index-seo.php/SATLINK____DIMACS).
Converting the example SAT to DIMACS Format yields the following.

```DIMACS Format
p cnf 5 3
1 -5 4 0
-1 5 3 4 0
-3 -4 0
```
DIMACS Format is widely distributed as an I/O format for SAT solver.
However, when solving a large SAT, the following problems occur.
- Need to create a file with thousands of lines.
- Confusion arises because of the inability to name variables meaningfully.

To solve these problems, Ravensat can be used.
Using Ravensat, propositional variables can be defined as local variables in Ruby.
```ruby
fuji_is_the_highest_mountain_in_japan = Ravensat::VarNode.new
```
In addition, you can write logical expressions intuitively.
```ruby
x = Ravensat::VarNode.new
y = Ravensat::VarNode.new

# (x or y) and (not x or y)
(x | y) & (~x | y)
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ravensat'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ravensat

## Usage
### Basic Usage
This is a basic usage example of the library.
```ruby
require 'ravensat'

# Define propositional variables
a = Ravensat::VarNode.new
b = Ravensat::VarNode.new

a.result #=> nil
b.result #=> nil

# Generate logical expressions as CNF
logic = (a | b) & (~a | b) & (a | ~b)

# Launch SAT solver
solver = Ravensat::Solver.new
solver.solve logic #=> true(SAT)

# Refer to the satisfiability
a.result #=> true
b.result #=> true
```

If you have SAT solver installed, you can write:
```ruby
# Launch SAT solver
solver = Ravensat::Solver.new("<solver_name>")
solver.solve logic
```
The available solvers are assumed to be those that can be I/O in the DIMACS Format.
At least, we have confirmed that it works properly with [MiniSat](https://github.com/niklasso/minisat).

If you do not use an external SAT solver, create a SAT solver object without any constructor arguments.
In that case, **Arcteryx**(the very simple SAT solver built into Ravensat) will launch.

### Extension Usage
In Ravensat::Extension, C-like variable definitions are available.

*Note: In Ravensat::Extension, all undefined variables and methods are caught by method_missing method.*

```ruby
require 'ravensat'

module Ravensat
  module Extension
    bool a, b
    logic = (a | b) & (~a | b) & (a | ~b)

    solver = Ravensat::Solver.new
    solver.solve logic #=> true

    a.result #=> true
    b.result #=> true
  end
end
```

### Extension Usage(CSP; Constraint Satisfaction Problem)
It is possible to define integer variables and to describe some integer constraints.
```ruby
require 'ravensat'

module Ravensat
  module Extension
    int a(1..10), b(1..10)
    constraint = (a.only_one & b.only_one & (a != b))

    solver = Ravensat::Solver.new
    solver.solve constraint #=> true

    a.result #=> 1
    b.result #=> 2
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/matsuda0528/ravensat.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
