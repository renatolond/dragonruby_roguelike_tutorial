# frozen_string_literal: true

module Dices
  # Abstract class for dices. The +max_value+ needs to be implemented in child classes for usage
  class Dice
    class << self
      # Rolls +count+ dices and returns the total value
      # @param count [Integer]
      # @return [Integer]
      def roll(count = 1)
        total = 0
        count.times do
          total += (rand(max_value) + 1)
        end
        total
      end

      # needs to be implemented in child classes
      # @return [Integer]
      def max_value
        raise "Not implemented"
      end
    end
  end
end
