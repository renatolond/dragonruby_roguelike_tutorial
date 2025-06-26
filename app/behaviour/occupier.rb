# frozen_string_literal: true

module Behaviour
  # This module enables the occupier behavior, allowing a mobile entity to occupy an entity with +Occupant+ behavior
  module Occupier
    attr_reader :tile

    # Updates the tile the entity is currently occupying with itself
    # @param args (see Game#tick)
    # @return [void]
    def update_tile(args)
      tile.occupant = nil if tile
      @tile = args.state.map.tiles[map_tile_x][map_tile_y]
      tile.occupant = self
    end

    # Can be used to test if this object has the Occupier behaviour
    # @return [Boolean]
    def enabled_occupier?
      true
    end
  end
end

# Monkey-patch the object class to indicate that most objects do not have this behaviour
class Object
  # Can be used to test if this object has the Occupier behaviour
  # @return [Boolean]
  def enabled_occupier?
    false
  end
end
