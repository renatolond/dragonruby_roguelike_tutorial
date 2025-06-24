# frozen_string_literal: true

module Scenes
  module Main
    class << self
      def tick(args); end
      def render(state, sprites, labels)
        sprites << state.map.tiles
      end
      def reset(state)
        Controllers::MapController.load_map(state)
      end
    end
  end
end
