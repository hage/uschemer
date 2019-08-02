# frozen_string_literal: true

require 'test-unit'
require "#{__dir__}/../let"

class TestLet < Test::Unit::TestCase
  def test_let?
    assert_true Let.let?([:let])
    assert_false Let.let?([])
    assert_false Let.let?([:hello])
  end

  def test_let_to_params_args_body
    params, args, body = Let.let_to_params_args_body([:let, [[:x, 3], [:y, 2]], [:+, :x, :y]])
    assert_equal [:x, :y], params
    assert_equal [3, 2], args
    assert_equal [:+, :x, :y], body

    assert_nil Let.let_to_params_args_body([:hage])
  end
end
