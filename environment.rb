# frozen_string_literal: true

module Environment
  module_function

  def lookup(var, env)
    alist = env.find{|a| a.key?(var)}
    raise "could not find value to variables: '#{var}" if alist.nil?

    alist[var]
  end

  def extend_env(params, args, env)
    [Hash[params.zip(args)]] + env
  end
end
