# -*- compile-command: "rake test"; -*-
# frozen_string_literal: true

module Let
  module_function

  def let?(exp)
    :let == Eval.car(exp)
  end
end
