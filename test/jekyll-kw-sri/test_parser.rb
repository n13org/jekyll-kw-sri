# frozen_string_literal: true

require 'test_helper'
require 'jekyll-kw-sri/configuration'
require 'jekyll-kw-sri/parser'

require 'liquid'
require 'liquid/profiler'

# class TestParser2 < JekyllUnitTest
#   context "simple page with nested linking" do
#     setup do
#       content = <<~CONTENT
#         ---
#         title: linking
#         ---
#         - 1 {% link _methods/sanitized_path.md %}
#         - 2 {% link _methods/site/generate.md %}
#       CONTENT
#       create_post(content,
#                   "source"           => source_dir,
#                   "destination"      => dest_dir,
#                   "collections"      => { "methods" => { "output" => true } },
#                   "read_collections" => true)
#     end

#     should "not cause an error" do
#       refute_match(%r!markdown-html-error!, @result)
#     end

#     should "have the URL to the 'sanitized_path' item" do
#       assert_match %r!1\s/methods/sanitized_path\.html!, @result
#     end

#     should "have the URL to the 'site/generate' item" do
#       assert_match %r!2\s/methods/site/generate\.html!, @result
#     end
#   end
# end

module Jekyll
  module KargWare
    module Integrity
      # Test the Liquid-Tag-Parser
      class TestParser < Minitest::Test
        def test_default_parser
          parser = Jekyll::KargWare::Integrity::Parser.new

          assert_equal parser.configuration.hash_type, 'sha384'
          assert_equal parser.configuration.write_source_mapping_url, true
          assert_equal parser.configuration.create_tmpfile, false
        end

        def test_parser_with_sha256
          parser = Jekyll::KargWare::Integrity::Parser.new('hashType' => 'sha256')

          assert_equal parser.configuration.hash_type, 'sha256'
          assert_equal parser.configuration.write_source_mapping_url, true
          assert_equal parser.configuration.create_tmpfile, false
        end

        def test_add_source_mapping_url_default
          parser = Jekyll::KargWare::Integrity::Parser.new

          assert_equal("XYZ\n/*# sourceMappingURL=dummy.css.map */", parser.add_source_mapping_url('dummy.scss', 'XYZ'))
        end

        def test_add_source_mapping_url_true
          parser = Jekyll::KargWare::Integrity::Parser.new({ 'writeSourceMappingURL' => true })

          assert_equal("XYZ\n/*# sourceMappingURL=dummy.css.map */", parser.add_source_mapping_url('dummy.scss', 'XYZ'))
        end

        def test_add_source_mapping_url_false
          parser = Jekyll::KargWare::Integrity::Parser.new({ 'writeSourceMappingURL' => false })

          assert_equal('XYZ', parser.add_source_mapping_url('dummy.scss', 'XYZ'))
        end

        def test_invalid_hashtype
          parser = Jekyll::KargWare::Integrity::Parser.new({ 'hashType' => 'shaFooBar' })

          assert_raises(Jekyll::KargWare::Integrity::InvalidHashTypeException) { parser.calc_integrity('dummy.scss', 'dummy data') }
        end

        def test_nico
          template = Liquid::Template.parse('{% if true %}IF{% else %}ELSE{% endif %}')
          assert_equal(['IF', 'ELSE'], template.root.nodelist[0].nodelist.map(&:nodelist).flatten)

          # # Liquid::Template.register_tag('sri_scss_hash', Jekyll::KargWare::SriScssHashTag)
          # template2 = Liquid::Template.parse('{% sri_scss_hash Nico.scss %}').render!()
          # assert_equal("Hallo", template2)

          # https://github.com/jekyll/jekyll/blob/9f8ac4eb7afc8e5cc47deced4cbe2c56df9d4266/test/test_tags.rb

          # var tag = Jekyll::KargWare::SriScssHashTag.new ("", "nico.css", "")
          # var render = tag.render(@context)

          # template = Liquid::Template.parse('{% raw %}Hallo{% endraw %}')
          # assert_equal("Hallo", template)

          # t = Template.new
          # t.parse('{%comment%}{%endcomment%}')
        end

        def test_default_hash
          parser = Jekyll::KargWare::Integrity::Parser.new

          assert_equal('sha384-rmBgLB2GNUCHgb0+M0Ccnxu4UANpgScLqMdc/xUrlfzLBbGHzlYfPdNd/8pahyyS', parser.calc_integrity('/folder/any-file.scss', 'Some CSS, SASS or SCSS data'))
        end

        def test_default_hash_with_tmp_file
          parser = Jekyll::KargWare::Integrity::Parser.new('createTmpfile' => true)

          assert_equal('sha384-NEbf2o7Y2GATnYHu1V66qX824UuFHjhs0KFcHJ0dhosIoYbSMjICUH/Fx4aCU7eW', parser.calc_integrity('/test/assets/css/test-generated.scss', 'Some CSS, SASS or SCSS data'))

          # Exits the temp file
          target_tmp_file = File.join(File.dirname(__FILE__), '..', 'assets', 'css', 'test-generated.scss.tmp')
          assert_equal true, File.exist?(target_tmp_file)

          # Compare file content
          tmp_file_content = File.read(target_tmp_file)
          content = "Some CSS, SASS or SCSS data\n/*# sourceMappingURL=test-generated.css.map */"
          assert_equal content, tmp_file_content

          # Clean up
          File.delete(target_tmp_file)
        end

        def test_sha256_hash
          parser = Jekyll::KargWare::Integrity::Parser.new('hashType' => 'sha256')

          assert_equal('sha256-qcdjYphy3ThHSS33e6PKE+0+nMH2TO+N5TfISpOQZEI=', parser.calc_integrity('/folder/any-file.scss', 'Some CSS, SASS or SCSS data'))
        end

        def test_sha256_hash_no_map
          parser = Jekyll::KargWare::Integrity::Parser.new('hashType' => 'sha256', 'writeSourceMappingURL' => false)

          assert_equal('sha256-HAIlc6vs074SVb8er2CJeXGT35yadAC20fUVgsB18RY=', parser.calc_integrity('/folder/any-file.scss', 'Some CSS, SASS or SCSS data'))
        end

        def test_sha384_hash
          parser = Jekyll::KargWare::Integrity::Parser.new('hashType' => 'sha384')

          assert_equal('sha384-rmBgLB2GNUCHgb0+M0Ccnxu4UANpgScLqMdc/xUrlfzLBbGHzlYfPdNd/8pahyyS', parser.calc_integrity('/folder/any-file.scss', 'Some CSS, SASS or SCSS data'))
        end

        def test_sha512_hash
          parser = Jekyll::KargWare::Integrity::Parser.new('hashType' => 'sha512')

          assert_equal('sha512-WD/EQwoOsJGPdAoxtkE64MUgiALqwZ46OidB7S9oSQ+2K6roNugrNB3q8PNIp1C29f7jCneERb3xenfe6jBUgQ==', parser.calc_integrity('/folder/any-file.scss', 'Some CSS, SASS or SCSS data'))
        end
      end
    end
  end
end
