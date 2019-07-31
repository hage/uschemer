# frozen_string_literal: true

require 'test-unit'
require File.join(__dir__, '../environment')

class TestEnvironment < Test::Unit::TestCase
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
  def test_lookup
    assert_equal 1, Environment.lookup(:a, [{a: 1}, {a: 2, b: 3}])
    assert_equal 2, Environment.lookup(:a, [{b: 1}, {a: 2, b: 3}])
    assert_raise(RuntimeError) do
      Environment.lookup(:a, [{b: 1}, {c: 1}])
    end
  end

  def test_extend_env
    assert_equal [{a: 1}], Environment.extend_env([:a], [1], [])
    assert_equal [{a: 1}, {a: 2}], Environment.extend_env([:a], [1], [{a: 2}])
  end
end
