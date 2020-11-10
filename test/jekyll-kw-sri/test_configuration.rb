# frozen_string_literal: true

require 'test_helper'
require 'jekyll-kw-sri/configuration'

module Jekyll
  module KargWare
    module Integrity
      # Test the Liquid-Tag-Configuration
      class TestConfiguration < Minitest::Test
        def test_default_configuration
          configuration = Jekyll::KargWare::Integrity::Configuration.new({})

          assert_equal configuration.hash_type, 'sha384'
          assert_equal configuration.write_source_mapping_url, true
          assert_equal configuration.create_tmpfile, false
        end

        def test_type_error
          configuration = Jekyll::KargWare::Integrity::Configuration.new('TypeError!')

          assert_equal configuration.hash_type, 'sha384'
          assert_equal configuration.write_source_mapping_url, true
          assert_equal configuration.create_tmpfile, false
        end

        def test_custom_hash_type
          configuration = Jekyll::KargWare::Integrity::Configuration.new('hashType' => 'foo')

          assert_equal configuration.hash_type, 'foo'
          assert_equal configuration.write_source_mapping_url, true
          assert_equal configuration.create_tmpfile, false
        end

        def hash_type
          configuration = Jekyll::KargWare::Integrity::Configuration.new({ 'hashType' => 'bar', 'writeSourceMappingURL' => false })

          assert_equal configuration.hash_type, 'bar'
          assert_equal configuration.write_source_mapping_url, false
          assert_equal configuration.create_tmpfile, false
        end

        def hash_type_change_create_tmpfile
          configuration = Jekyll::KargWare::Integrity::Configuration.new({ 'hashType' => 'foo bar', 'writeSourceMappingURL' => false, 'createTmpfile' => true })

          assert_equal configuration.hash_type, 'foo bar'
          assert_equal configuration.write_source_mapping_url, false
          assert_equal configuration.create_tmpfile, true
        end
      end
    end
  end
end
