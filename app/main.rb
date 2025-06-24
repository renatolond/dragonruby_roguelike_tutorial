# frozen_string_literal: true

require_relative "scenes/main"
require_relative "scenes/title"

require_relative "controllers/enemy_controller"
require_relative "controllers/map_controller"

require_relative "entities/base"
require_relative "entities/static"
require_relative "entities/floor"
require_relative "entities/wall"
require_relative "entities/mobile"
require_relative "entities/player"
require_relative "entities/enemy"
require_relative "entities/zombie"

# This class contains the logic around the game.
# It will call the scenes as needed to render the current frame
class Game
  attr_reader :active_scene

  def initialize
    goto_title
  end

  # @param args [GTK::Args]
  # @return [void]
  def tick(args)
    sprites = []
    labels = []
    active_scene.tick(args)
    active_scene.render(args.state, sprites, labels)
    args.gtk.warn_array_primitives!
    args.outputs.primitives << args.gtk.framerate_diagnostics_primitives
    render(args, sprites, labels)
  end

  # @param args (see #tick)
  # @param sprites [Array]
  # @param labels [Array]
  def render(args, sprites, labels)
    args.outputs.sprites << sprites
    args.outputs.labels << labels
  end

  # Changes the scene to the title scene
  # @return [void]
  def goto_title
    @active_scene = Scenes::Title
  end

  # Changes the scene to the main (game) scene
  # @param args (see #tick)
  # @return [void]
  def goto_game(args)
    Scenes::Main.reset(args.state)
    @active_scene = Scenes::Main
  end
end

$game ||= Game.new # rubocop:disable Style/GlobalVars

# The main method called by DragonRuby.
# It is used in the game loop to render the game
#
# @param args [GTK::Args]
# @return [void]
def tick(args)
  $game.tick(args) # rubocop:disable Style/GlobalVars
end
