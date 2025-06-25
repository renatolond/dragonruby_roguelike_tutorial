# frozen_string_literal: true

module Entities
  class Enemy < Mobile
    # (see Game#tick)
    def tick(args)
      act(args)
      @x = map_x - args.state.map.x
      @y = map_y - args.state.map.y
    end

    POSSIBLE_DIRECTIONS = %i[up down left right].freeze

    VISIBLE_RANGE = 320

    # Decides what do based on some basic heuristics
    # @param args (see Game#tick)
    # @return [void]
    def act(args)
      if manhattan_distance(args.state.player) < VISIBLE_RANGE
        seek_player(args)
      else
        patrol(args)
      end
    end

    # Attempts to get closer to the player
    # @param args (see Game#tick)
    # @return [void]
    def seek_player(args)
      player = args.state.player

      # Think of a way to make the movement more natural
      direction = if player.map_x < map_x
        :left
      elsif player.map_x > map_x
        :right
      elsif player.map_y < map_y
        :down
      elsif player.map_y > map_y
        :up
      end

      move_towards(args, direction)
    end

    # +move_towards+ one of +POSSIBLE_DIRECTIONS+
    # @param args (see Game#tick)
    # @return [void]
    def patrol(args)
      direction = POSSIBLE_DIRECTIONS.sample
      move_towards(args, direction)
    end

    # Attempts to move in a direction
    #
    # @param args (see Game#tick)
    # @param direction [Symbol] one of +POSSIBLE_DIRECTIONS+
    # @return [void]
    def move_towards(args, direction)
      target_x = map_x
      target_y = map_y
      case direction
      when :up
        target_y += Controllers::MapController::TILE_HEIGHT
      when :down
        target_y -= Controllers::MapController::TILE_HEIGHT
      when :right
        target_x += Controllers::MapController::TILE_WIDTH
      when :left
        target_x -= Controllers::MapController::TILE_WIDTH
      end
      attempt_move(args, target_x, target_y) do
        update_tile(args)
      end
    end
  end
end
