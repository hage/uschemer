# -*- compile-command: "rake test TEST=test/test_let.rb"; -*-
# frozen_string_literal: true

require __dir__ + '/list'

module Let
  extend List

  module_function

  def eval(exp, env)
    params, args, body = let_to_params_args_body(exp)
    nexp = [[:lambda, params, body]] + args
    Eval.eval(nexp, env)
  end

  def let?(exp)
    :let == car(exp)
  end

  def let_to_params_args_body(exp)
    return nil if !let?(exp)

    bind_exp = car(cdr(exp))
    [
      bind_exp.map{|x| car(x)},
      bind_exp.map{|x| car(cdr(x))},
      car(cdr(cdr(exp)))
    ]
  end
end
