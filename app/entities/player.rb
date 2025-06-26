# frozen_string_literal: true

module Entities
  # The player is virtually a singleton and should only be initialized by calling +.spawn+
  class Player < Mobile
    include Behaviour::HitPoints
    include Behaviour::Attacker
    attr_accessor :took_action

    # (see Game#tick)
    def tick(args)
      self.took_action = false

      keyboard = args.inputs.keyboard
      target_x = if keyboard.key_down.right || keyboard.key_down.d
        map_x + ::Controllers::MapController::TILE_WIDTH
      elsif keyboard.key_down.left || keyboard.key_down.a
        map_x - ::Controllers::MapController::TILE_WIDTH
      else
        map_x
      end
      target_y = if keyboard.key_down.up || keyboard.key_down.w
        map_y + ::Controllers::MapController::TILE_HEIGHT
      elsif keyboard.key_down.down || keyboard.key_down.s
        map_y - ::Controllers::MapController::TILE_HEIGHT
      else
        map_y
      end
      attempt_move(args, target_x, target_y) do
        self.took_action = true
        args.state.redraw_entities = true
        args.state.redraw_play_area = true
        ::Controllers::MapController.tick(args)
        update_tile(args)
      end
    end

    private

      def initialize(map_x: 0, map_y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT) # rubocop:disable Naming/MethodParameterName
        super(map_x: map_x, map_y: map_y, w: w, h: h, path: "sprites/player.png")
        @hp = 50
        @defense = 10
        @attack = 3
      end
  end
end
