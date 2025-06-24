# frozen_string_literal: true

module Entities
  # The base class for the game entities (static and dynamic)
  class Base
    attr_sprite

    SPRITE_WIDTH = 32
    SPRITE_HEIGHT = 32

    def initialize(x: 0, y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT, path: "app/sprites/null_sprite.png") # rubocop:disable Naming/MethodParameterName
      @x = x
      @y = y
      @w = w
      @h = h
      @path = path
    end
  end
end
