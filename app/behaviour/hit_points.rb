# frozen_string_literal: true

module Behaviour
  # This behavior adds hit points, defense and related methods
  module HitPoints
    attr_reader :max_hp, :hp, :defense

    # @return [Boolean]
    def alive?
      hp.positive?
    end

    # Takes the damage inflicted
    # @param damage [Integer]
    # @return [void]
    def take_damage(damage)
      @hp = hp - damage
      @hp = 0 if @hp.negative?
      return unless @hp.zero?

      Controllers::EventLogController.log_event("#{self.class.name} died!")
    end

    # Can be used to test if this object has the HitPoints behaviour
    # @return [Boolean]
    def enabled_hit_points?
      true
    end
  end
end

# Monkey-patch the object class to indicate that most objects do not have this behaviour
class Object
  # Can be used to test if this object has the HitPoints behaviour
  # @return [Boolean]
  def enabled_hit_points?
    false
  end
end
