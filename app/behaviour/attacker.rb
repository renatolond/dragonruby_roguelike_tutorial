# frozen_string_literal: true

module Behaviour
  module Attacker
    attr_reader :attack, :crit_bonus

    # Deals damage to other entities with +Behaviour::HitPoints+
    # @param other [#enabled_hit_points?]
    def deal_damage(other)
      return unless other.enabled_hit_points?

      roll = Dices::D20.roll
      total_attack = attack
      total_attack += crit_bonus if roll == 20

      if roll >= other.defense
        Controllers::EventLogController.log_event("#{"CRIT! " if roll == 20}#{self.class.name} hit #{other.class.name} for #{total_attack} damage")
        other.take_damage(total_attack)
      else
        Controllers::EventLogController.log_event("#{self.class.name} missed #{other.class.name}!")
      end
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
