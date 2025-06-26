# frozen_string_literal: true

module Entities
  # The player is virtually a singleton and should only be initialized by calling +.spawn+
  class Player < Mobile
    include Behaviour::HitPoints
    include Behaviour::Attacker
    attr_accessor :took_action, :took_damage

    # @return [Symbol]
    def faction
      :player
    end

    # @return [String]
    def self.name
      "Player"
    end

    # (see Game#tick)
    def tick(args)
      self.took_action = false
      self.took_damage = false

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

    # @return [Array<Hash{Symbol=>Object}>]
    def stats_labels
      [
        { x: 16, y: 700, text: hp_string }.merge!(hp_string_color)
      ]
    end

    # (see Behaviour::HitPoints.take_damage)
    def take_damage(damage)
      super
      self.took_damage = true
    end

    private

      # @return [Hash{Symbol=>Integer}] A color hash depending on the HP of the player
      def hp_string_color
        if hp / max_hp >= 0.5
          { r: 10, g: 200, b: 10, a: 255 }
        elsif hp / max_hp >= 0.2
          { r: 255, g: 165, b: 0, a: 255 }
        else
          { r: 220, g: 0, b: 0, a: 255 }
        end
      end

      # @return [String]
      def hp_string
        hp_label = format("%2d", hp)
        max_hp_label = format("%2d", max_hp)
        "HP: #{hp_label} / #{max_hp_label}"
      end

      def initialize(map_x: 0, map_y: 0, w: SPRITE_WIDTH, h: SPRITE_HEIGHT) # rubocop:disable Naming/MethodParameterName
        super(map_x: map_x, map_y: map_y, w: w, h: h, path: "sprites/player.png")
        @max_hp = 50
        @hp = max_hp
        @defense = 10
        @attack = 3
        @crit_bonus = 1
      end
  end
end
