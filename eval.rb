# -*- compile-command: "rake test"; -*-
# frozen_string_literal: true

require File.join(__dir__, 'list')

module Eval
  extend List

  module_function

  def eval(exp)
    if !list?(exp)
      if immediate_val?(exp)
        exp
      else
        lookup_primitive_fun(exp)
      end
    else
      fun = Eval.eval(car(exp))
      args = eval_list(cdr(exp))
      apply(fun, args)
    end
  end

  def apply(fun, args)
    fun.call(*args)
  end

  def eval_list(exp)
    exp.map{|e| Eval.eval(e)}
  end

  def lookup_primitive_fun(exp)
    case exp
    when :+
      ->(a, b) {a + b}
    when :-
      ->(a, b) {a - b}
    when :*
      ->(a, b) {a * b}
    else
      raise "unknown function: #{exp}"
    end
  end
end
