module HG
  module Weather

    class Temperature
      attr_accessor :celsius
      attr_accessor :fahrenheit

      def initialize temperature, format = :c
        return if temperature.nil?
        temperature = temperature.to_f

        if format == :c
          @celsius = temperature
          @fahrenheit = ((temperature * 1.8) + 32).round(2)
        else
          @fahrenheit = temperature
          @celsius = ((temperature - 32) / 1.8).round(2)
        end
      end

      def get_with_format
        case Weather.temperature
        when :celsius
          @celsius
        when :fahrenheit
          @fahrenheit
        end
      end

      def inspect
        self.to_s
      end

      def to_s
        "#{self.get_with_format}º #{Weather.temperature.to_s[0].upcase}"
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
