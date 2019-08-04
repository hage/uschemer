# -*- compile-command: "rake test"; -*-
# frozen_string_literal: true

require __dir__ + '/list'
require __dir__ + '/env'
require __dir__ + '/lambda'
require __dir__ + '/let'

module Eval
  extend List

  module_function

  def eval(exp, env)
    if !list?(exp)
      if immediate_val?(exp)
        exp
      else
        lookup_primitive_fun(exp) || Env.lookup(exp, env)
      end
    elsif special_form?(exp)
      eval_special_form(exp, env)
    else
      fun = Eval.eval(car(exp), env)
      args = eval_list(cdr(exp), env)
      apply(fun, args)
    end
  end

  def special_form?(exp)
    Lambda.lambda?(exp) || Let.let?(exp)
  end

  def eval_special_form(exp, env)
    if Lambda.lambda?(exp)
      Lambda.eval(exp, env)
    elsif Let.let?(exp)
      Let.eval(exp, env)
    end
  end

  def apply(fun, args)
    if primitive_fun?(fun)
      apply_primitive_fun(fun, args)
    else
      Lambda.apply(fun, args)
    end
  end

  def primitive_fun?(fun)
    fun[0] == :prim
  end

  def apply_primitive_fun(fun, args)
    fun[1].call(*args)
  end

  def eval_list(exp, env)
    exp.map{|e| Eval.eval(e, env)}
  end

  def lookup_primitive_fun(exp)
    fun = case exp
          when :+
            ->(a, b) {a + b}
          when :-
            ->(a, b) {a - b}
          when :*
            ->(a, b) {a * b}
          end
    fun ? [:prim, fun] : nil
  end
end
