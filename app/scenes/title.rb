# frozen_string_literal: true

module Scenes
  module Title
    class << self
      # (see Game#tick)
      def tick(args)
        args.state.timer ||= 0
        args.state.timer += 1
        return if args.state.timer < 30

        $game.goto_game(args) if args.inputs.keyboard.space # rubocop:disable Style/GlobalVars
      end

      # Resets the scene back to its original state by modifying the state
      #
      # @param state [GTK::OpenEntity]
      # @return [void]
      def reset(state)
        return unless state

        state.timer = 0
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
