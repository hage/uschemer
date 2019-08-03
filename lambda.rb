# frozen_string_literal: true

require __dir__ + '/list'
require __dir__ + '/env'

module Lambda
  extend List

  module_function

  def eval(exp, env)
    make_closure(exp, env)
  end

  def lambda?(exp)
    :lambda == car(exp)
  end

  def make_closure(exp, env)
    params = car(cdr(exp))
    body = car(cdr(cdr(exp)))
    [:closure, params, body, env]
  end

  def apply(closure, args)
    params, body, env = closure_to_params_body_env(closure)
    nenv = Env.extend(params, args, env)
    Eval.eval(body, nenv)
  end

  def closure_to_params_body_env(closure)
    [closure[1], closure[2], closure[3]]
  end
end
