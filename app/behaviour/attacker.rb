# frozen_string_literal: true

module Behaviour
  module Attacker
    attr_reader :attack

    # Deals damage to other entities with +Behaviour::HitPoints+
    # @param other [#enabled_hit_points?]
    def deal_damage(other)
      return unless other.enabled_hit_points?

      other.take_damage(attack)
    end

    # Can be used to test if this object has the Attacker behaviour
    # @return [Boolean]
    def enabled_attacker?
      true
    end
  end
end

# Monkey-patch the object class to indicate that most objects do not have this behaviour
class Object
  # Can be used to test if this object has the Attacker behaviour
  # @return [Boolean]
  def enabled_attacker?
    false
  end
end
