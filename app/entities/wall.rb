# frozen_string_literal: true

module Entities
  class Wall < Static
    def initialize(map_x: 0, map_y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT) # rubocop:disable Naming/MethodParameterName
      super(map_x: map_x, map_y: map_y, w: w, h: h, path: "sprites/wall.png")
    end

    # @return [Boolean]
    def blocking?
      true
    end
  end
end
