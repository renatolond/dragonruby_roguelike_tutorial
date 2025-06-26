# frozen_string_literal: true

module Entities
  # The base class for the game entities (static and dynamic)
  class Base
    attr_sprite
    attr_reader :map_x, :map_y

    SPRITE_WIDTH = 32
    SPRITE_HEIGHT = 32

    def initialize(map_x: 0, map_y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT, path: "app/sprites/null_sprite.png") # rubocop:disable Naming/MethodParameterName
      @map_x = map_x
      @map_y = map_y
      @x = map_x
      @y = map_y
      @w = w
      @h = h
      @path = path
    end

    # @return [Boolean]
    def blocking?
      false
    end

    # @return [Symbol]
    def faction
      :neutral
    end

    # Simplified linear distance to other entity. Will raise if +other+ is not an entity
    # @param other [Entities::Base]
    # @raise [ArgumentError] if other is something other than an Entity
    # @return [Integer]
    def manhattan_distance(other)
      raise ArgumentError unless other.is_a?(Entities::Base)

      x_diff = other.map_x - map_x
      y_diff = other.map_y - map_y
      x_diff.abs + y_diff.abs
    end

    # (see Controllers::MapController.map_x_to_idx_x)
    def map_tile_x
      Controllers::MapController.map_x_to_idx_x(map_x)
    end

    # (see Controllers::MapController.map_y_to_idx_y)
    def map_tile_y
      Controllers::MapController.map_y_to_idx_y(map_y)
    end
  end
end
