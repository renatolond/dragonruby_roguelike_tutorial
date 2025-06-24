# frozen_string_literal: true

module Entities
  class Mobile < Base
    # @param args (see Game#tick)
    # @param target_x [Integer] The intended destination x-coordinate
    # @param target_y [Integer] The intended destination y-coordinate
    # @yield [] Yields if move is allowed before the x/y coordinates are modified
    # @return [Type] Description
    def attempt_move(args, target_x, target_y)
      idx_x = Controllers::MapController.map_x_to_idx_x(target_x)
      idx_y = Controllers::MapController.map_y_to_idx_y(target_y)
      return if Controllers::MapController.blocked?(args, idx_x, idx_y)
      return if @map_x == target_x && map_y == target_y

      @map_x = target_x
      @map_y = target_y
      yield if block_given?
      @x = map_x - args.state.map.x
      @y = map_y - args.state.map.y
    end
  end
end
