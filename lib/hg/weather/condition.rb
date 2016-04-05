require 'hg/weather/temperature'
require 'hg/weather/speed'

module HG
  module Weather

    class Condition
      ONE_DAY = 86_400

      # Public: Temperature
      attr_accessor :temperature

      # Public: Max Temperature
      attr_accessor :max_temperature

      # Public: Min Temperature
      attr_accessor :min_temperature

      # Public: Humidity
      attr_accessor :humidity

      # Public: Image ID
      attr_accessor :image_id

      # Public: Description
      attr_accessor :description

      # Public: Slug
      attr_accessor :slug

      # Public: Wind speedy
      attr_accessor :wind_speed

      # Public: Sunrise
      attr_accessor :sunrise

      # Public: Sunset
      attr_accessor :sunset

      # Public: Currently, day or night
      attr_accessor :currently

      # Public: Datetime, if forecast time is always midnight
      attr_accessor :datetime

      # Public: Is forecast
      attr_accessor :is_forecast

      def initialize(options = {})
        if options.count != 0
          @temperature      = Temperature.new(options[:temperature]) if options[:temperature]
          @max_temperature  = Temperature.new(options[:max_temperature]) if options[:max_temperature]
          @min_temperature  = Temperature.new(options[:min_temperature]) if options[:min_temperature]
          @humidity         = options[:humidity].to_i if options[:humidity]
          @image_id         = options[:image_id] if options[:image_id]
          @description      = options[:description] if options[:description]
          @slug             = options[:slug].to_sym if options[:slug]
          @wind_speed       = Speed.new(options[:wind_speed]) if options[:wind_speed]
          @currently        = (options[:currently] == 'dia' ? :day : :night) if options[:currently]
          @datetime         = process_datetime(options[:date], options[:time]) if options[:date]
          @sunrise          = process_sunrise(options[:sunrise]) if options[:sunrise]
          @sunset           = process_sunset(options[:sunset]) if options[:sunset]
          @is_forecast      = options[:is_forecast] if options[:is_forecast]
        end
      end

      def is_day?
        return nil if self.currently.nil?
        self.currently == :day
      end

      def is_night?
        return nil if self.currently.nil?
        self.currently == :night
      end

      protected
      def process_datetime date, time = nil
        return Time.now if date.nil?

        return Time.strptime((date + ' ' + (time ? time : '00:00')), '%d/%m/%Y %H:%M')
      end

      def process_sunset sunset
        return nil if sunrise.nil? || self.datetime.nil?
        sunset = Time.parse(sunset)

        return (sunset > midnight_of(self.datetime + ONE_DAY) ? sunset - ONE_DAY : sunset)
      end

      def process_sunrise sunrise
        return nil if sunrise.nil? || self.datetime.nil?
        sunrise = Time.parse(sunrise)

        return (sunrise < midnight_of(self.datetime + ONE_DAY) ? sunrise + ONE_DAY : sunrise)
      end

      def midnight_of time
        time = Time.now if time.nil?
        Time.new(time.year, time.month, time.day)
      end
    end

  end
end
