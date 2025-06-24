# frozen_string_literal: true

module Entities
  class Mobile < Base
    def attempt_move(args, target_x, target_y)
      idx_x = Controllers::MapController.map_x_to_idx_x(target_x)
      idx_y = Controllers::MapController.map_y_to_idx_y(target_y)
      return if Controllers::MapController.blocked?(args, idx_x, idx_y)

      @map_x = target_x
      @map_y = target_y
      yield if block_given?
      @x = map_x - args.state.map.x
      @y = map_y - args.state.map.y
    end
  end
end
