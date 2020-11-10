# frozen_string_literal: true

require 'bundler/gem_tasks'

task default: [:test]

def name
  'jekyll-kw-sri'
end

def version
  JekyllKwSri::VERSION
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  # test.name = "Run test with rake"
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "#{name} #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
