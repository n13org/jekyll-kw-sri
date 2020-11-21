# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

# https://medium.com/@paulfarino/wrap-your-assets-in-a-gem-3ad7ecf5b075
# https://gorails.com/episodes/creating-gems-for-frontend-javascript-libraries
# https://lokalise.com/blog/create-a-ruby-gem-basics/

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-kw-sri'
  spec.version       = JekyllKwSri::VERSION
  spec.summary       = 'Jekyll CSS/JS integrity hash plugin'
  spec.description   = <<-LONGDESCRIPTION
    Jekyll plugin which calculate the integrity hash of CSS (SCSS, SASS) and JS files.
    The crossorigin will set to anonymous. The plugin uses Jekyll Filter, Tags and customen converters.
  LONGDESCRIPTION
  spec.authors       = ['Nicolas Karg', 'n13.org - Open-Source by KargWare']
  spec.email         = 'rubygems.org@n13.org'
  spec.homepage      = 'https://github.com/n13org/jekyll-kw-sri'
  spec.license       = 'MIT'
  spec.metadata      = {
    'bug_tracker_uri' => 'https://github.com/n13org/jekyll-kw-sri/issues',
    'source_code_uri' => 'https://github.com/n13org/jekyll-kw-sri/'
  }

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.files         = Dir[
                        'README.md', 'LICENSE', 'CHANGELOG.md',
                        'lib/**/*.rb',
                        '_includes/kw-integrity-css.html', '_includes/kw-integrity-js.html'
                       ]
  # spec.files         = `git ls-files -z`.split("\x0")
  ## Copied from https://github.com/pages-themes/minimal/blob/master/jekyll-theme-minimal.gemspec
  # spec.files         = `git ls-files -z`.split("\x0").select do |f|
  #   f.match(%r{^((_includes|_layouts|_sass|assets)/|(LICENSE|README)((\.(txt|md|markdown)|$)))}i)
  # end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4'

  spec.add_dependency 'jekyll', '>= 3.8'
end
