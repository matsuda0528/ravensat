# Ravensat

Ravensat is an interface to SAT Solver .
In order to use Ravensat, you need to install SAT Solver and specify the name of the Solver .
(If you do not specify SAT Solver, it will use the one bundled in the gem .)


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
### General Usage
```ruby
require 'ravensat'

a = Ravensat::VarNode.new
b = Ravensat::VarNode.new

a.value #=> nil
b.value #=> nil

logic = (a | b) & (~a | b) & (a | ~b)

solver = Ravensat::Solver.new
solver.solve logic #=> true(SAT)

a.value #=> true
b.value #=> true
```

### Extension Usage(SAT)
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
