# frozen_string_literal: true

module Scenes
  module Title
    class << self
      # (see Game#tick)
      def tick(args)
        $game.goto_game(args) if args.inputs.keyboard.space # rubocop:disable Style/GlobalVars
      end

      # @param _args [GTK::Args]
      # @param sprites [Array]
      # @param labels [Array]
      def render(_args, sprites, labels)
        labels << { x: 550, y: 300, text: "My RogueLike Tutorial" }
        labels << { x: 550, y: 110, text: "Press space to start" }

        sprites << { x: 600, y: 500, w: 100, h: 80, path: "sprites/misc/dragon-0.png" }
      end
    end
  end
end
