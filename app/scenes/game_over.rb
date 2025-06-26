# frozen_string_literal: true

module Scenes
  module GameOver
    class << self
      # (see Game#tick)
      def tick(args)
        $game.goto_title(args) if args.inputs.keyboard.space # rubocop:disable Style/GlobalVars
      end

      # @param _args [GTK::Args]
      # @param _sprites [Array]
      # @param labels [Array]
      def render(_args, _sprites, labels)
        labels << { x: 550, y: 300, text: "You died." }
        labels << { x: 550, y: 110, text: "Press space to go back to the title screen" }
      end
    end
  end
end
