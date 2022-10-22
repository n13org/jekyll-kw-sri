# frozen_string_literal: true

module Jekyll
  module KargWare
    # string format class
    class StringNumberFormater
      def format(input, decimals = 0, fill_to_max_length_with_zeros = 0)
        input = ("%.#{decimals}f" % input)

        if fill_to_max_length_with_zeros.positive?
          # ("%#{fill_to_max_length_with_zeros}d" % input)
          input.to_s.rjust(fill_to_max_length_with_zeros, '0')
        else
          input
        end
      end
    end
  end
end
