# frozen_string_literal: true

module Behaviour
  # This module adds the Occupant behavior, allowing someone to occupy a static entity
  module Occupant
    attr_accessor :occupant

    # @return [Boolean]
    def blocking?
      occupant&.blocking? || super
    end

    # Can be used to test if this object has the Occupant behaviour
    # @return [Boolean]
    def enabled_occupant?
      true
    end
  end
end

# Monkey-patch the object class to indicate that most objects do not have this behaviour
class Object
  # Can be used to test if this object has the Occupant behaviour
  # @return [Boolean]
  def enabled_occupant?
    false
  end
end
