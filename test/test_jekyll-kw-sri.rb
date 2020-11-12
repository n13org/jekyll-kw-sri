# frozen_string_literal: true

require 'jekyll'
# require_relative '../testbroken/jekyll/helper'

require 'jekyll-kw-sri'
require 'jekyll-kw-sri/configuration'
# require 'jekyll-kw-sri/converter'
require 'jekyll-kw-sri/parser'

# Test class
class TestParser2 < Minitest::Test
  # class TestParser2 < JekyllUnitTest
  def test_nico
    # converter = Jekyll::KargWare::Integrity::Converter.new
    # assert_equal '_sass', converter.convert_extended

    # @site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
    # @context = Liquid::Context.new({}, {}, { site: @site })
    # site = Jekyll::Site.new(site_configuration)

    # Liquid::Template.register_tag('sri_scss_hash', Jekyll::KargWare::SriScssHashTag)
    template2 = Liquid::Template.parse('{% sri_scss_hash /test/assets/css/test-dummy.scss %}').render!
    assert_equal('sha384-UjOLM/hnGPBBNf7ocV6PJ38/j2/U3Q+t5uR8bl2FiuKrr+9PSBNJ+g00gfQslcoL', template2)

    # https://github.com/jekyll/jekyll/blob/9f8ac4eb7afc8e5cc47deced4cbe2c56df9d4266/test/test_tags.rb

    # var tag = Jekyll::KargWare::SriScssHashTag.new ("", "nico.css", "")
    # var render = tag.render(@context)

    # template = Liquid::Template.parse('{% raw %}Hallo{% endraw %}')
    # assert_equal("Hallo", template)

    # t = Template.new
    # t.parse('{%comment%}{%endcomment%}')
  end
end
