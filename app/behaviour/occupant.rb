# frozen_string_literal: true

module Behaviour
  module Occupant
    attr_reader :tile

    # Updates the tile the entity is currently occupying with itself
    # @param args (see Game#tick)
    # @return [void]
    def update_tile(args)
      tile.occupant = nil if tile
      @tile = args.state.map.tiles[map_tile_x][map_tile_y]
      tile.occupant = self
    end
  end
end
