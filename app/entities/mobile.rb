# frozen_string_literal: true

module Entities
  class Mobile < Base
    # @param args (see Game#tick)
    # @param target_x [Integer] The intended destination x-coordinate
    # @param target_y [Integer] The intended destination y-coordinate
    # @yield [] Yields if move is allowed before the x/y coordinates are modified
    # @return [Type] Description
    def attempt_move(args, target_x, target_y)
      idx_x = Controllers::MapController.map_x_to_idx_x(target_x)
      idx_y = Controllers::MapController.map_y_to_idx_y(target_y)
      return if Controllers::MapController.blocked?(args, idx_x, idx_y)
      return if @map_x == target_x && map_y == target_y

      @map_x = target_x
      @map_y = target_y
      yield if block_given?
      @x = map_x - args.state.map.x
      @y = map_y - args.state.map.y
    end

    class << self
      # @param state [GTK::OpenEntity]
      # @param idx_x [Integer] The index of the player in the x-axis
      # @param idx_y [Integer] The index of the player in the y-axis
      def spawn_near(state, idx_x, idx_y)
        radius = 1
        attempt = 0

        tile = state.map.tiles[idx_x][idx_y]

        while tile.nil? || tile.blocking?
          idx_x = ((idx_x - radius)..(idx_x + radius)).to_a.sample # TODO: optimize this to avoid generating an array at every spawn
          idx_y = ((idx_y - radius)..(idx_y + radius)).to_a.sample # TODO: optimize this to avoid generating an array at every spawn

          tile = state.map.tiles.dig(idx_x, idx_y)

          attempt += 1
          next unless attempt >= radius * 8

          radius += 1
          attempt = 0
        end

        new(map_x: idx_x * SPRITE_WIDTH, map_y: idx_y * SPRITE_HEIGHT)
      end
    end
  end
end
