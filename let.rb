# -*- compile-command: "rake test TEST=test/test_let.rb"; -*-
# frozen_string_literal: true

$LOAD_PATH << __dir__
require 'eval'
require 'list'

module Let
  extend List

  module_function

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
