# -*- compile-command: "rake test"; -*-
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
end
