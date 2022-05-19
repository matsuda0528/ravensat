# Ravensat

[![Ruby](https://github.com/matsuda0528/ravensat/actions/workflows/main.yml/badge.svg)](https://github.com/matsuda0528/ravensat/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/ravensat.svg)](https://badge.fury.io/rb/ravensat)

Ravensat is an interface to SAT solver in Ruby.
In order to use Ravensat, you need to install SAT solver.
(If you do not install SAT solver, it will use the one bundled in the gem.)

About [SAT](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem), [SAT solver](https://en.wikipedia.org/wiki/SAT_solver)


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

a.value #=> nil
b.value #=> nil

# Generate logical expressions as CNF
logic = (a | b) & (~a | b) & (a | ~b)

# Launch SAT solver
solver = Ravensat::Solver.new
solver.solve logic #=> true(SAT)

# Refer to the satisfiability
a.value #=> true
b.value #=> true
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

    a.value #=> true
    b.value #=> true
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
