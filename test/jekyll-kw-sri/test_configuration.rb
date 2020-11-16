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

          assert_equal 'sha384', configuration.hash_type
          assert_equal true, configuration.write_source_mapping_url
          assert_equal false, configuration.create_tmpfile
        end

        def test_type_error
          configuration = Jekyll::KargWare::Integrity::Configuration.new('TypeError!')

          assert_equal 'sha384', configuration.hash_type
          assert_equal true, configuration.write_source_mapping_url
          assert_equal false, configuration.create_tmpfile
        end

        def test_custom_hash_type
          configuration = Jekyll::KargWare::Integrity::Configuration.new('hashType' => 'foo')

          assert_equal 'foo', configuration.hash_type
          assert_equal true, configuration.write_source_mapping_url
          assert_equal false, configuration.create_tmpfile
        end

        def hash_type
          configuration = Jekyll::KargWare::Integrity::Configuration.new({ 'hashType' => 'bar', 'writeSourceMappingURL' => false })

          assert_equal 'bar', configuration.hash_type
          assert_equal false, configuration.write_source_mapping_url
          assert_equal false, configuration.create_tmpfile
        end

        def hash_type_change_create_tmpfile
          configuration = Jekyll::KargWare::Integrity::Configuration.new({ 'hashType' => 'foo bar', 'writeSourceMappingURL' => false, 'createTmpfile' => true })

          assert_equal 'foo bar', configuration.hash_type
          assert_equal false, configuration.write_source_mapping_url
          assert_equal true, configuration.create_tmpfile
        end
      end
    end
  end
end
