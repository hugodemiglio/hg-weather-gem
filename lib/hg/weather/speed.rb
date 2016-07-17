module HG
  module Weather

    class Speed
      attr_accessor :km_h
      attr_accessor :miles_h

      attr_accessor :direction

      def initialize speed, direction = nil, format = :km
        return if speed.nil?
        speed = speed.to_f

        if format == :km
          @km_h = speed
          @miles_h = (speed * 0.621371).round(2)
        else
          @miles_h = speed
          @km_h = (speed * 1.60934).round(2)
        end
      end

      def get_with_format
        case Weather.speed
        when :km
          @km_h
        when :miles
          @miles_h
        end
      end

      def inspect
        self.to_s
      end

      def to_s
        "#{self.get_with_format} #{Weather.speed.to_s.downcase}/h"
      end

      def to_f
        self.get_with_format
      end

      def to_i
        self.get_with_format.to_i
      end
    end

  end
end
