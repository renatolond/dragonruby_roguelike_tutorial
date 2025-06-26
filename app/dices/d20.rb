# frozen_string_literal: true

module Dices
  # A 20-sided dice
  class D20 < Dice
    class << self
      # @return [Integer]
      def max_value
        20
      end
    end
  end
end
