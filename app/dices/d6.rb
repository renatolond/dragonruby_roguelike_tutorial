# frozen_string_literal: true

module Dices
  # A 6-sided dice
  class D6 < Dice
    class << self
      # @return [Integer]
      def max_value
        6
      end
    end
  end
end
