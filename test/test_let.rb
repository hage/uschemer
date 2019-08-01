# frozen_string_literal: true

require 'test-unit'
require "#{__dir__}/../let"

class TestLet < Test::Unit::TestCase
  def test_let?
    assert_true Let.let?([:let])
    assert_false Let.let?([])
    assert_false Let.let?([:hello])
  end
end
