# frozen_string_literal: true

require 'rake/testtask'

task default: [:test]

Rake::TestTask.new do |test|
  test.test_files = Dir['test/**/test_*.rb']
  test.verbose = false
  test.warning = true
  test.options = '--verbose=n --no-stop-on-failure'
end
