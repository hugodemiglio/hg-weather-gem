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
          @fahrenheit = (temperature * 1.8) + 32
        else
          @fahrenheit = temperature
          @celsius = (temperature - 32) / 1.8
        end
      end

      def inspect
        self.to_s
      end

      def to_s
        "#{@celsius}º C"
      end
    end

  end
end
