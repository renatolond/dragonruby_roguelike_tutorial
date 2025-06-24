# frozen_string_literal: true

module Scenes
  module Main
    class << self
      # (see Game#tick)
      def tick(args)
        args.state.player.tick(args)
      end

      # Renders anything related to the scene
      def render(state, sprites, labels)
        sprites << state.map.tiles
        sprites << state.player
      end

      # Resets the scene back to its original state by modifying the state
      #
      # @param state [GTK::OpenEntity]
      # @return [void]
      def reset(state)
        Controllers::MapController.load_map(state)
        state.player = ::Entities::Player.spawn(2, 2)
      end
    end
  end
end
