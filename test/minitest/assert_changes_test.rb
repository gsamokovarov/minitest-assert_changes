require 'test_helper'
require 'securerandom'

class Minitest::AssertChangesTest < Minitest::Test
  def setup
    @object = Class.new do
      attr_accessor :num
      def increment
        self.num += 1
      end

      def decrement
        self.num -= 1
      end
    end.new
    @object.num = 0
  end

  def test_assert_changes_pass
    assert_changes '@object.num' do
      @object.increment
    end
  end

  def test_assert_changes_pass_with_lambda
    assert_changes -> { @object.num } do
      @object.increment
    end
  end

  def test_assert_changes_with_from_option
    assert_changes '@object.num', from: 0 do
      @object.increment
    end
  end

  def test_assert_changes_with_from_option_with_wrong_value
    assert_raises Minitest::Assertion do
      assert_changes '@object.num', from: -1 do
        @object.increment
      end
    end
  end

  def test_assert_changes_with_to_option
    assert_changes '@object.num', to: 1 do
      @object.increment
    end
  end

  def test_assert_changes_with_wrong_to_option
    assert_raises Minitest::Assertion do
      assert_changes '@object.num', to: 2 do
        @object.increment
      end
    end
  end

  def test_assert_changes_with_from_option_and_to_option
    assert_changes '@object.num', from: 0, to: 1 do
      @object.increment
    end
  end

  def test_assert_changes_with_from_and_to_options_and_wrong_to_value
    assert_raises Minitest::Assertion do
      assert_changes '@object.num', from: 0, to: 2 do
        @object.increment
      end
    end
  end

  def test_assert_changes_works_with_any_object
    retval = silence_warnings do
      assert_changes :@new_object, from: nil, to: 42 do
        @new_object = 42
      end
    end

    assert_equal 42, retval
  end

  def test_assert_changes_works_with_nil
    oldval = @object

    retval = assert_changes :@object, from: oldval, to: nil do
      @object = nil
    end

    assert_nil retval
  end

  def test_assert_changes_with_to_and_case_operator
    token = nil

    assert_changes 'token', to: /\w{32}/ do
      token = SecureRandom.hex
    end
  end

  def test_assert_changes_with_to_and_from_and_case_operator
    token = SecureRandom.hex

    assert_changes 'token', from: /\w{32}/, to: /\w{32}/ do
      token = SecureRandom.hex
    end
  end

  def test_assert_no_changes_pass
    assert_no_changes '@object.num' do
      # ...
    end
  end

  def test_assert_no_changes_with_message
    error = assert_raises Minitest::Assertion do
      assert_no_changes '@object.num', '@object.num should not change' do
        @object.increment
      end
    end

    assert_equal "@object.num should not change.\n\"@object.num\" did change to 1.\nExpected: 0\n  Actual: 1", error.message
  end

  private

  alias :assert_not_equal :refute_equal

  def silence_warnings
    with_warnings(nil) { yield }
  end

  def with_warnings(flag)
    old_verbose, $VERBOSE = $VERBOSE, flag
    yield
  ensure
    $VERBOSE = old_verbose
  end
end
