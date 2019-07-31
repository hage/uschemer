# frozen_string_literal: true

module Environment
  module_function

  def lookup(var, env)
    alist = env.find{|a| a.key?(var)}
    raise "could not find value to variables: '#{var}" if alist.nil?

    alist[var]
  end

  def extend_env(params, args, env)
    alist = params.zip(args)
    h = {}
    alist.each do |k, v|
      h[k] = v
    end
    [h] + env
  end
end
