# frozen_string_literal: true

module List
  module_function

  def car(exp)
    exp[0]
  end

  def cdr(exp)
    exp[1..-1]
  end

  def list?(exp)
    exp.is_a?(Array)
  end

  def immediate_val?(exp)
    exp.is_a?(Integer)
  end
end
