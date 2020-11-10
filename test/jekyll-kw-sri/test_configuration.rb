# frozen_string_literal: true

require 'test_helper'
require 'jekyll-kw-sri/configuration'

module Jekyll
  module KargWare
    module Integrity
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

        def test_customHashtype
          configuration = Jekyll::KargWare::Integrity::Configuration.new("hashType" => "foo")
      
          assert_equal configuration.hashType, 'foo'
          assert_equal configuration.write_sourceMappingURL, true
          assert_equal configuration.create_tmpfile, false
        end

        def test_customHashtype_changeSourceMappingUrl
          configuration = Jekyll::KargWare::Integrity::Configuration.new({"hashType" => "bar", "writeSourceMappingURL" => false})
      
          assert_equal configuration.hashType, 'bar'
          assert_equal configuration.write_sourceMappingURL, false
          assert_equal configuration.create_tmpfile, false
        end

        def test_customHashtype_changeSourceMappingUrl_changeCreateTmpfile
          configuration = Jekyll::KargWare::Integrity::Configuration.new({"hashType" => "foo bar", "writeSourceMappingURL" => false, "createTmpfile" => true})
      
          assert_equal configuration.hashType, 'foo bar'
          assert_equal configuration.write_sourceMappingURL, false
          assert_equal configuration.create_tmpfile, true
        end
      end
    end
  end
end