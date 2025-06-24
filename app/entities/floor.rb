# frozen_string_literal: true

module Entities
  class Floor < Static
    def initialize(map_x: 0, map_y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT) # rubocop:disable Naming/MethodParameterName
      super(map_x: map_x, map_y: map_y, w: w, h: h, path: "sprites/floor.png")
    end
  end
end
