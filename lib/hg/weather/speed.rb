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
          @miles_h = speed * 0.621371
        else
          @miles_h = speed
          @km_h = speed * 1.60934
        end
      end
    end

  end
end
