# Minitest::AssertChanges

Introduces `assert_changes` and `assert_no_changes` to `Minitest`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-assert_changes'
```

And then execute:

    $ bundle

## Usage

`assert_changes` is a more general `assert_difference` that works with any
value.

    assert_changes 'Error.current', from: nil, to: 'ERR' do
      expected_bad_operation
    end

Can be called with strings, to be evaluated in the binding (context) of
the block given to the assertion, or a lambda.

    assert_changes -> { Error.current }, from: nil, to: 'ERR' do
      expected_bad_operation
    end

The `from` and `to` arguments are compared with the case operator (`===`).

    assert_changes 'Error.current', from: nil, to: Error do
      expected_bad_operation
    end

This is pretty useful, if you need to loosely compare a value. For example,
you need to test a token has been generated and it has that many random
characters.

    user = User.start_registration
    assert_changes 'user.token', to: /\w{32}/ do
      user.finish_registration
    end

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
