# frozen_string_literal: true

module Controllers
  module EventLogController
    class << self
      attr_reader :logged_event_this_tick

      # @param _args [GTK::Args]
      def tick(_args)
        @logged_event_this_tick = false
      end

      # Resets the scene back to its original state by modifying the state
      #
      # @param _state [GTK::OpenEntity]
      # @return [void]
      def reset(_state)
        @event_logs = []
        @logged_event_this_tick = false
      end

      LOG_TOP = 650
      # @return [Array<Hash{Symbol=>Object}>]
      def events_as_labels
        idx = 0
        labels = Array.new(@event_logs.size)
        @event_logs.each do |event|
          alpha = 255 - (idx * 15)
          labels << { x: 16, y: LOG_TOP - (idx * 40), text: event, r: 230, g: 230, b: 230, a: alpha }
          idx += 1
        end
        labels
      end

      MAX_EVENT_LOG_SIZE = 16
      # Logs an event
      # @param event [String] The event to be logged
      # @return [void]
      def log_event(event)
        @event_logs.prepend(event)
        @event_logs.pop if @event_logs.size > MAX_EVENT_LOG_SIZE
        @logged_event_this_tick = true
      end
    end
  end
end
