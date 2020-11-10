# frozen_string_literal: true

# Gem.autoload(:RakefileNotFoundError, 'exceptions')
require 'test_helper'

# Copied from: https://github.com/rubygems/rubygems-test

# require 'helper'
# require 'rbconfig'
# require 'yaml'

class TestExecute < Minitest::Test
  # taken straight out of rake
  # DEFAULT_RAKEFILES = ['rakefile', 'Rakefile', 'rakefile.rb', 'Rakefile.rb']

  def setup
    super
    # @test = Gem::Commands::TestCommand.new
  end
  
#   def test_always_true
#     assert_equal 1, 1
#   end

#   def test_always_false
#     assert_equal yes, no
#   end

  def test_versionfile_exists
    assert File.exist?("./lib/version.rb"), "No 'version.rb' file found under the 'lib' folder!"
  end

#   def test_rakefile_exists
#     find_rakefile("./")
#   end

#   #
#   # Locate the rakefile for a gem name and version
#   #
#   def find_rakefile(path)
#     rakefile = DEFAULT_RAKEFILES.
#       map  { |x| File.join(path, x) }.
#       find { |x| File.exist?(x) }

#     unless(File.exist?(rakefile) rescue nil)
#       alert_error "Couldn't find rakefile -- this gem cannot be tested. Aborting." 
#       raise Gem::RakefileNotFoundError, "Couldn't find rakefile, cannot start a test."
#     end
#   end

#   def test_05_find_rakefile
#     install_stub_gem({ :files => ["Rakefile"] })

#     spec = @test.find_gem('test-gem', '0.0.0')

#     assert_nothing_raised { @test.find_rakefile(spec.full_gem_path, spec) }

#     uninstall_stub_gem
#     install_stub_gem({ :files => "" })

#     spec = @test.find_gem('test-gem', '0.0.0')

#     assert_raises(Gem::RakeNotFoundError) { @test.find_rakefile(spec.full_gem_path, spec) }

#     uninstall_stub_gem
#   end
end