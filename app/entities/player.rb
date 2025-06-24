# frozen_string_literal: true

module Entities
  # The player is virtually a singleton and should only be initialized by calling +.spawn+
  class Player < Mobile
    # (see Game#tick)
    def tick(args)
      @y += ::Controllers::MapController::TILE_HEIGHT if args.inputs.keyboard.key_down.up || args.inputs.keyboard.key_down.w
      @y -= ::Controllers::MapController::TILE_HEIGHT if args.inputs.keyboard.key_down.down || args.inputs.keyboard.key_down.s
      @x += ::Controllers::MapController::TILE_WIDTH if args.inputs.keyboard.key_down.right || args.inputs.keyboard.key_down.d
      @x -= ::Controllers::MapController::TILE_WIDTH if args.inputs.keyboard.key_down.left || args.inputs.keyboard.key_down.a
    end

    private

      def initialize(x: 0, y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT) # rubocop:disable Naming/MethodParameterName
        super(x: x, y: y, w: w, h: h, path: "sprites/player.png")
      end

      class << self
        # @param idx_x [Integer] The index of the player in the x-axis
        # @param idx_y [Integer] The index of the player in the y-axis
        def spawn(idx_x, idx_y)
          new(x: idx_x * SPRITE_WIDTH, y: idx_y * SPRITE_HEIGHT)
        end
      end
  end
end
