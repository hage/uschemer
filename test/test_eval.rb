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
  def test_list?
    assert_true Eval.list?([])
    assert_false Eval.list?(1)
  end

  def immediate_val?
    assert_true Eval.immediate_val?(1)
    assert_false Eval.immediate_val?([])
  end

  def test_lookup_primitive_fun
    assert_equal 10, Eval.lookup_primitive_fun(:+).call(8, 2)
    assert_equal 10, Eval.lookup_primitive_fun(:*).call(5, 2)
    assert_equal 10, Eval.lookup_primitive_fun(:-).call(12, 2)
    assert_raise(RuntimeError) do
      Eval.lookup_primitive_fun(1)
    end
  end
end
