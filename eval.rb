# frozen_string_literal: true

module Eval
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

  def list?(exp)
    exp.is_a?(Array)
  end

  def immediate_val?(exp)
    exp.is_a?(Integer)
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
