# frozen_string_literal: true

require 'test_helper'
require 'jekyll-kw-sri/StringNumberFormater'

module Jekyll
  module KargWare
    # Test Class
    class TestParser < Minitest::Test
      def test_format_defaults_decimal_digits
        parser = Jekyll::KargWare::StringNumberFormater.new

        # get a random number 0.1 to 99000
        r = rand(0.1..99_000)

        assert_equal parser.format(r), parser.format(r, 0)
      end

      def test_format_zero_decimal_digits
        parser = Jekyll::KargWare::StringNumberFormater.new

        assert_equal '9999', parser.format(9999.12345, 0)
        assert_equal '778', parser.format(777.888, 0)
        assert_equal '10', parser.format(10, 0)
        assert_equal '9', parser.format(9.000, 0)
        assert_equal '0', parser.format(0.49, 0)
        assert_equal '0', parser.format(0.5, 0)
        assert_equal '1', parser.format(0.51, 0)
      end

      def test_format_two_decimal_digits
        parser = Jekyll::KargWare::StringNumberFormater.new

        assert_equal '9999.12', parser.format(9999.12345, 2)
        assert_equal '777.89', parser.format(777.888, 2)
        assert_equal '10.00', parser.format(10, 2)
        assert_equal '9.00', parser.format(9.000, 2)
        assert_equal '0.49', parser.format(0.49, 2)
        assert_equal '0.50', parser.format(0.5, 2)
        assert_equal '0.51', parser.format(0.51, 2)
      end

      def test_format_two_decimal_digits_filled_up_to_4_leading_zeros
        parser = Jekyll::KargWare::StringNumberFormater.new

        assert_equal '9999', parser.format(9999.12345, 0, 4)
        assert_equal '0778', parser.format(777.888, 0, 4)
        assert_equal '0010', parser.format(10, 0, 4)
        assert_equal '0009', parser.format(9.000, 0, 4)
        assert_equal '0000', parser.format(0.49, 0, 4)
        assert_equal '0000', parser.format(0.5, 0, 4)
        assert_equal '0001', parser.format(0.51, 0, 4)
      end

      def test_format_two_decimal_digits_filled_up_to_8_leading_zeros
        parser = Jekyll::KargWare::StringNumberFormater.new

        assert_equal '09999.12', parser.format(9999.12345, 2, 8)
        assert_equal '00777.89', parser.format(777.888, 2, 8)
        assert_equal '00010.00', parser.format(10, 2, 8)
        assert_equal '00009.00', parser.format(9.000, 2, 8)
        assert_equal '00000.49', parser.format(0.49, 2, 8)
        assert_equal '00000.50', parser.format(0.5, 2, 8)
        assert_equal '00000.51', parser.format(0.51, 2, 8)
      end
    end
  end
end
