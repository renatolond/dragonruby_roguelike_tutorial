# frozen_string_literal: true

module Entities
  # The base class for any static entities (floors, walls, etc)
  class Static < Base
    # (see Game#tick)
    def tick(args)
      @x = map_x - args.state.map.x
      @y = map_y - args.state.map.y
    end
  end
end
