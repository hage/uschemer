# frozen_string_literal: true

require 'test-unit'
require __dir__ + '/../eval'

class TestEval < Test::Unit::TestCase
  def test_lookup_primitive_fun
    prim = Eval.lookup_primitive_fun(:+)
    assert_true Eval.primitive_fun?(prim)
    assert_equal 10, Eval.apply(prim, [8, 2])

    prim = Eval.lookup_primitive_fun(:*)
    assert_true Eval.primitive_fun?(prim)
    assert_equal 10, Eval.apply(prim, [5, 2])

    prim = Eval.lookup_primitive_fun(:-)
    assert_true Eval.primitive_fun?(prim)
    assert_equal 10, Eval.apply(prim, [12, 2])

    assert_nil Eval.lookup_primitive_fun(1)
  end

  def test_apply
    assert_equal 10, Eval.apply([:prim, ->(a, b) {a + b}], [4, 6])
  end

  def test_eval_list
    assert_equal [1, 2, 3], Eval.eval_list([1, 2, 3], [])
  end

  def test_eval
    assert_equal 1, Eval.eval(1, [])
    assert_equal 1, Eval.eval([:-, 3, 2], [])
    assert_equal 1, Eval.eval([:-, [:+, 5, 2], [:*, 3, 2]], [])
  end

  def test_let_eval
    assert_equal 3, Eval.eval([:let, [[:x, 1], [:y, 2]], [:+, :x, :y]], [])

    assert_equal 2, Eval.eval([:let, [[:x, 2]],
                              [:let, [[:fun, [:lambda, [], :x]]],
                               [:let, [[:x, 1]],
                                [:fun]]]],
                             [])
  end

  def test_lambda
    assert_equal 16, Eval.eval([[:lambda, [:x], [:*, :x, :x]], 4], [])
    assert_equal 16, Eval.eval([[:lambda, [], [:*, :x, :x]]], [{x: 4}])
  end
end
