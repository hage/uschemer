# frozen_string_literal: true

require 'test-unit'
require "#{__dir__}/../eval"

class TestEval < Test::Unit::TestCase
  class << self
    def startup
      # テスト群の実行前に呼ばれる
    end
    def shutdown
      # テスト群の実行後に呼ばれる
    end
  end
  def setup
    # 毎回テスト実行前に呼ばれる
  end
  def cleanup
    # テストがpassedになっているときテスト実行後teardownの前に呼ばれる
  end
  def teardown
    # 毎回テスト実行後に呼ばれる
  end

  ################ Test Cases
  def test_lookup_primitive_fun
    assert_equal 10, Eval.lookup_primitive_fun(:+).call(8, 2)
    assert_equal 10, Eval.lookup_primitive_fun(:*).call(5, 2)
    assert_equal 10, Eval.lookup_primitive_fun(:-).call(12, 2)
    assert_raise(RuntimeError) do
      Eval.lookup_primitive_fun(1)
    end
  end

  def test_apply
    assert_equal 10, Eval.apply(->(a, b) {a + b}, [4, 6])
  end

  def test_eval_list
    assert_equal [1, 2, 3], Eval.eval_list([1, 2, 3])
  end

  def test_eval
    assert_equal 1, Eval.eval(1)
    assert_equal 1, Eval.eval([:-, 3, 2])
    assert_equal 1, Eval.eval([:-, [:+, 5, 2], [:*, 3, 2]])
  end
end
