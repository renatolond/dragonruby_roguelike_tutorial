# frozen_string_literal: true

module Entities
  class Floor < Static
    def initialize(x: 0, y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT) # rubocop:disable Naming/MethodParameterName
      super(x: x, y: y, w: w, h: h, path: "sprites/floor.png")
    end
  end
end
