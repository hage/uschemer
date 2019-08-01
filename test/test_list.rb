# frozen_string_literal: true

require 'test-unit'
require "#{__dir__}/../list"

class TestList < Test::Unit::TestCase
  def test_list?
    assert_true List.list?([])
    assert_false List.list?(1)
  end

  def test_immediate_val?
    assert_true List.immediate_val?(1)
    assert_false List.immediate_val?([])
  end

  def test_car
    assert_equal :a, List.car(%i[a b])
    assert_equal nil, List.car([])
  end

  def test_cdr
    assert_equal nil, List.cdr([])
    assert_equal %i[b], List.cdr(%i[a b])
    assert_equal %i[b c], List.cdr(%i[a b c])
  end
end
