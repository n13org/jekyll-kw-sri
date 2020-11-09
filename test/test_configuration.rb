# frozen_string_literal: true

require 'test_helper'
require 'jekyll-kw-sri/Configuration'

class TestConfiguration < Minitest::Test
    def test_default_configuration
      configuration = Jekyll::KargWare::Integrity::Configuration.new({})
  
      assert_equal configuration.hashType, 'sha384'
      assert_equal configuration.write_sourceMappingURL, true
      assert_equal configuration.create_tmpfile, false
    end
  
    def test_type_error
      configuration = Jekyll::KargWare::Integrity::Configuration.new('TypeError!')
  
      assert_equal configuration.hashType, 'sha384'
      assert_equal configuration.write_sourceMappingURL, true
      assert_equal configuration.create_tmpfile, false
    end
end