# frozen_string_literal: true

module Controllers
  module EnemyController
    class << self
      # (see Game#tick)
      def tick(args)
        return unless args.state.player.took_action

        args.state.enemies.each { |enemy| enemy.tick(args) }
      end

      # Spawn the enemies to set the initial state
      # @param state [GTK::OpenEntity]
      # @return [void]
      def spawn_enemies(state)
        state.enemies ||= []
        30.times do
          tile_x = rand(Controllers::MapController::MAP_WIDTH)
          tile_y = rand(Controllers::MapController::MAP_HEIGHT)
          spawn_enemy(
            state,
            tile_x,
            tile_y,
            Entities::Zombie
          )
        end
      end

      private

        # Spawns a single enemy at a given position with the given type
        # @param state (see .spawn_enemies)
        # @param tile_x [Integer]
        # @param tile_y [Integer]
        # @param enemy_type [Class]
        # @return [void]
        def spawn_enemy(state, tile_x, tile_y, enemy_type)
          state.enemies << enemy_type.spawn_near(
            state,
            tile_x,
            tile_y
          )
        end
    end
  end
end
