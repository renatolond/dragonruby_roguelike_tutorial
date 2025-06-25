# frozen_string_literal: true

module Scenes
  module Main
    TEXT_AREA_WIDTH = 1280 - Controllers::MapController::PLAY_AREA_WIDTH
    TEXT_AREA_HEIGHT = 720

    class << self
      # (see Game#tick)
      def tick(args)
        args.state.player.tick(args)
        Controllers::EnemyController.tick(args)
      end

      # @param args (see Game#tick)
      # @param sprites [Array]
      # @param _labels [Array]
      def render(args, sprites, _labels)
        render_play_area(args) if args.state.redraw_play_area
        render_entities(args) if args.state.redraw_entities
        render_text_area(args) if args.state.redraw_text_area
        sprites << {
          x: 0,
          y: 0,
          w: Controllers::MapController::PLAY_AREA_WIDTH,
          h: Controllers::MapController::PLAY_AREA_HEIGHT,
          source_x: 0,
          source_y: 0,
          source_w: Controllers::MapController::PLAY_AREA_WIDTH,
          source_h: Controllers::MapController::PLAY_AREA_HEIGHT,
          path: :play_area
        }
        sprites << {
          x: 0,
          y: 0,
          w: Controllers::MapController::PLAY_AREA_WIDTH,
          h: Controllers::MapController::PLAY_AREA_HEIGHT,
          source_x: 0,
          source_y: 0,
          source_w: Controllers::MapController::PLAY_AREA_WIDTH,
          source_h: Controllers::MapController::PLAY_AREA_HEIGHT,
          path: :entities
        }
        sprites << { x: Controllers::MapController::PLAY_AREA_WIDTH, y: 0, w: TEXT_AREA_WIDTH, h: TEXT_AREA_HEIGHT, source_x: 0, source_y: 0, source_w: TEXT_AREA_WIDTH, source_h: TEXT_AREA_HEIGHT, path: :text_area }
      end

      # Resets the scene back to its original state by modifying the state
      #
      # @param state [GTK::OpenEntity]
      # @return [void]
      def reset(state)
        Controllers::MapController.load_map(state)
        Controllers::EnemyController.spawn_enemies(state)
        state.player = ::Entities::Player.spawn_near(state, 2, 2)
        state.redraw_play_area = true
        state.redraw_entities = true
        state.redraw_text_area = true
      end

      private

        # Renders the map tiles in the play area, only static elements
        # @param args (see Game#tick)
        # @return [void]
        def render_play_area(args)
          args.state.redraw_play_area = false
          args.render_target(:play_area).sprites << args.state.map.tiles
        end

        # Renders the mobile entities, player and the enemies
        # @param args (see Game#tick)
        # @return [void]
        def render_entities(args)
          args.state.redraw_entities = false
          args.render_target(:entities).sprites << args.state.enemies
          args.render_target(:entities).sprites << args.state.player
        end

        # Renders the text area
        # @param args (see Game#tick)
        # @return [void]
        def render_text_area(args)
          args.state.redraw_text_area = false
          args.render_target(:text_area).solids << { x: 0, y: 0, w: TEXT_AREA_WIDTH, h: TEXT_AREA_HEIGHT, r: 10, g: 21, b: 33 }
        end
    end
  end
end
