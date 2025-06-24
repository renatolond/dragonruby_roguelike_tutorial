# frozen_string_literal: true

module Entities
  class Enemy < Mobile
    # (see Game#tick)
    def tick(args)
      patrol(args)
      @x = map_x - args.state.map.x
      @y = map_y - args.state.map.y
    end

    POSSIBLE_DIRECTIONS = %i[up down left right].freeze

    # Attempts to move in a direction
    #
    # @param args (see Game#tick)
    # @return [void]
    def patrol(args)
      direction = POSSIBLE_DIRECTIONS.sample
      case direction
      when :up
        attempt_move(args, map_x, map_y + Controllers::MapController::TILE_HEIGHT)
      when :down
        attempt_move(args, map_x, map_y - Controllers::MapController::TILE_HEIGHT)
      when :left
        attempt_move(args, map_x - Controllers::MapController::TILE_WIDTH, map_y)
      when :right
        attempt_move(args, map_x + Controllers::MapController::TILE_WIDTH, map_y)
      end
    end
  end
end
