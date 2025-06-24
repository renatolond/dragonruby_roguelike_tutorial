# frozen_string_literal: true

module Controllers
  module MapController
    MAP_WIDTH = 80
    MAP_HEIGHT = 45
    TILE_WIDTH = 32
    TILE_HEIGHT = 32
    class << self
      # Loads the map into the state
      # @param state [GTK::OpenEntity]
      def load_map(state)
        state.map.tiles = map_tiles
      end

      private

        # @return [Array<Array<Entities::Base>>] A 2-dimension array of sprites to be drawn
        def map_tiles
          map_tiles = Array.new(MAP_WIDTH) { Array.new(MAP_HEIGHT) }
          MAP_WIDTH.times do |idx_x|
            MAP_HEIGHT.times do |idx_y|
              map_tiles[idx_x][idx_y] = if idx_y.zero? || idx_y == (MAP_HEIGHT - 1) || idx_x.zero? || idx_x == (MAP_WIDTH - 1)
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
          tile_type.new(x: idx_x * TILE_WIDTH, y: idx_y * TILE_HEIGHT, w: TILE_WIDTH, h: TILE_HEIGHT)
        end
    end
  end
end
