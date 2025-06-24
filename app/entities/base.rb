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
  end
end
