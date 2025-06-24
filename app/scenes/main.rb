# frozen_string_literal: true

module Scenes
  module Main
    class << self
      def tick(args); end
      def render(state, sprites, labels); end
      def reset(state); end
    end
  end
end
