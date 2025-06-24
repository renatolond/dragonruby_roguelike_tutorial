# frozen_string_literal: true

module Scenes
  module Main
    class << self
      # (see Game#tick)
      def tick(args)
        args.state.player.tick(args)
        Controllers::EnemyController.tick(args)
      end

      # @param state [GTK::OpenEntity]
      # @param sprites [Array]
      # @param _labels [Array]
      def render(state, sprites, _labels)
        sprites << state.map.tiles
        sprites << state.enemies
        sprites << state.player
      end

      # Resets the scene back to its original state by modifying the state
      #
      # @param state [GTK::OpenEntity]
      # @return [void]
      def reset(state)
        Controllers::MapController.load_map(state)
        Controllers::EnemyController.spawn_enemies(state)
        state.player = ::Entities::Player.spawn_near(state, 2, 2)
      end
    end
  end
end
