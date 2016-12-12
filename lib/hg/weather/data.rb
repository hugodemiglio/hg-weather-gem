require 'hg/weather/condition'

module HG
  module Weather

    class Data

      attr_accessor :request, :requested_at, :key_status
      attr_accessor :condition, :forecast, :woeid
      attr_accessor :cid, :city_name, :search_method

      def initialize params, host_name, use_ssl = true
        query_params = params.map{|k,v| "#{k.to_s}=#{v.to_s}"}.join('&')
        @request = (use_ssl ? 'https' : 'http') + host_name + '?' + query_params
        @requested_at = Time.now

        request_data = JSON.parse(open(self.request).read)

        if request_data['results']
          results = request_data['results']

          @key_status = (params[:key] ? (request_data['key_status'] ? :valid : :invalid) : :empty)

          @city_name = results['city_name']
          @search_method = request_data['by']
          @cid = results['cid']
          @woeid = params[:woeid] if request_data['by'] == 'woeid'

          @condition = Condition.new(to_current(results))

          @forecast = []
          results['forecast'].each do |forecast|
            @forecast << Condition.new(to_forecast(forecast))
          end
        end

        return self
      end


      def to_current r
        {
          temperature: r['temp'],
          description: r['description'],
          slug: r['condition_slug'],
          wind_speed: r['wind_speedy'],
          humidity: r['humidity'],
          image_id: r['img_id'],
          sunrise: r['sunrise'],
          sunset: r['sunset'],
          currently: r['currently'],
          date: r['date'],
          time: r['time'],
          is_forecast: false
        }
      end

      # TODO: Improve to get year of date
      def to_forecast r
        {
          date: (Weather.locale == :en ? Time.now.year.to_s + '-' + r['date'] : r['date'] + '/' + Time.now.year.to_s),
          max_temperature: r['max'],
          min_temperature: r['min'],
          description: r['description'],
          image_id: r['img_id'],
          slug: r['condition'],
          is_forecast: true
        }
      end
    end

  end
end
