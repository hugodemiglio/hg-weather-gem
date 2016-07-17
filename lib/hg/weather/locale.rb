module HG
  module Weather

    class Locale

      @formats = {
        en: {
          date: '%Y-%m-%d',
          short_date: '%m-%d',
          datetime: '%Y-%m-%d %H:%M',
          temperature: :fahrenheit,
          speed: :miles,
          day: :day,
          sunrise: 'sunrise',
          sunset: 'sunset'
        },
        :'pt-br' => {
          date: '%d/%m/%Y',
          short_date: '%d/%m',
          datetime: '%d/%m/%Y %H:%M',
          temperature: :celsius,
          speed: :km,
          day: :dia,
          sunrise: 'nascer do sol',
          sunset: 'por do sol'
        }
      }

      def self.get_format item
        Weather.locale = :en unless @formats.has_key?(Weather.locale.to_sym)

        return @formats[Weather.locale.to_sym][item]
      end

    end

  end
end
