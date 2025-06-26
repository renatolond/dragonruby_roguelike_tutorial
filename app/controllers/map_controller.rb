# frozen_string_literal: true

module Controllers
  # Module response for movement and logic around the map
  module MapController
    MAP_WIDTH = 80
    MAP_HEIGHT = 45
    TILE_WIDTH = 32
    TILE_HEIGHT = 32
    MIN_X = 0
    MIN_Y = 0
    MAX_X = (MAP_WIDTH * TILE_WIDTH) - Scenes::Main::PLAY_AREA_WIDTH
    MAX_Y = (MAP_HEIGHT * TILE_HEIGHT) - Scenes::Main::PLAY_AREA_HEIGHT

    MOVEMENT_ZONE_BUFFER_X = 8 * TILE_WIDTH
    MOVEMENT_ZONE_BUFFER_Y = 6 * TILE_HEIGHT

    class << self
      # Loads the map into the state
      # @param state [GTK::OpenEntity]
      def load_map(state)
        state.map.tiles = map_tiles
        state.map.x = 0
        state.map.y = 0
      end

      # (see Game#tick)
      def tick(args)
        player = args.state.player
        map = args.state.map
        player_x_offset = player.map_x - map.x
        player_y_offset = player.map_y - map.y
        if player_x_offset < MOVEMENT_ZONE_BUFFER_X
          map.x = [MIN_X, map.x - TILE_WIDTH].max
        elsif player_x_offset > (Scenes::Main::PLAY_AREA_WIDTH - MOVEMENT_ZONE_BUFFER_X)
          map.x = [map.x + TILE_WIDTH, MAX_X].min
        end
        if player_y_offset < MOVEMENT_ZONE_BUFFER_Y
          map.y = [MIN_Y, map.y - TILE_HEIGHT].max
        elsif player_y_offset > (Scenes::Main::PLAY_AREA_HEIGHT - MOVEMENT_ZONE_BUFFER_Y)
          map.y = [map.y + TILE_HEIGHT, MAX_Y].min
        end

        map.tiles.each { |arr| arr.each { |t| t.tick(args) } }
      end

      # Transforms a map x (virtual position) into a tile x (screen position)
      # @param map_x [Integer]
      # @return [Integer]
      def map_x_to_idx_x(map_x)
        (map_x / TILE_WIDTH).floor
      end

      # Transforms a map y (virtual position) into a tile y (screen position)
      # @param map_y [Integer]
      # @return [Integer]
      def map_y_to_idx_y(map_y)
        (map_y / TILE_HEIGHT).floor
      end

      # @param idx_x (see .tile_for)
      # @param idx_y (see .tile_for)
      # @param args (see .tick)
      # @return [Boolean]
      def blocked?(args, idx_x, idx_y)
        tile = tile_at(args, idx_x, idx_y)
        return true unless tile

        tile.blocking?
      end

      # @param idx_x (see .tile_for)
      # @param idx_y (see .tile_for)
      # @param args (see .tick)
      # @return [nil,Entities::Mobile]
      def tile_occupant(args, idx_x, idx_y)
        tile = tile_at(args, idx_x, idx_y)
        return nil unless tile&.enabled_occupant?

        tile.occupant
      end

      # @param idx_x (see .tile_for)
      # @param idx_y (see .tile_for)
      # @param args (see .tick)
      # @return [nil,Entities::Static]
      def tile_at(args, idx_x, idx_y)
        return nil if idx_x.negative? || idx_x > MAP_WIDTH - 1
        return nil if idx_y.negative? || idx_y > MAP_HEIGHT - 1

        args.state.map.tiles[idx_x][idx_y]
      end

      private

        # @return [Array<Array<Entities::Base>>] A 2-dimension array of sprites to be drawn
        def map_tiles
          map_tiles = Array.new(MAP_WIDTH) { Array.new(MAP_HEIGHT) }
          MAP_WIDTH.times do |idx_x|
            MAP_HEIGHT.times do |idx_y|
              map_tiles[idx_x][idx_y] = if (idx_y.zero? || idx_y == (MAP_HEIGHT - 1) || idx_x.zero? || idx_x == (MAP_WIDTH - 1)) ||
                                           rand(8).zero?
                tile_for(idx_x, idx_y, ::Entities::Wall)
              else
                tile_for(idx_x, idx_y, ::Entities::Floor)
              end
            end
          end
          map_tiles
        end

        # @param idx_x [Integer] The index of the tile in the x-axis
        # @param idx_y [Integer] The index of the tile in the y-axis
        # @param tile_type [Class] A subclass of Entities::Base
        # @return [Entities::Base]
        def tile_for(idx_x, idx_y, tile_type)
          tile_type.new(map_x: idx_x * TILE_WIDTH, map_y: idx_y * TILE_HEIGHT, w: TILE_WIDTH, h: TILE_HEIGHT)
        end
    end
  end
end
