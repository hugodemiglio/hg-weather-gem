# HG Weather

Welcome to official HG Weather's Ruby Gem!

Now you can simple get worldwide weather data (current and forecast) from HG Weather API directly on your Ruby Application!

You can search any city in the world!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hg-weather'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hg-weather

## Usage

### Configuring

You can configure all of HG Weather params, but not all of them are required.

```ruby
require 'hg/weather'

HG::Weather.setup do |config|
  # You can generate your key on hgbrasil.com/weather
  # Key is required for search by name, geolocation or IP.
  config.api_key = 'my-key'

  # Set locale for response, default is english, available: pt-br, en
  config.locale = :en

  # Use SSL on request, default and recommended is true
  config.use_ssl = true

  # Coming... If you are using Rails, request can be cached on cache engine
  config.use_rails_cache = true

  # You can set default search, by these methods below:

  # config.woeid = '2487956' # set default with an WOEID (Where on Earth ID)
  # config.city_name = 'Cupertino, CA' # set city name for search
  # config.latitude = -41.0 # set latitude
  # config.longitude = -41.0 # set longitude
  # config.client_ip = :remote # your IP or 'remote' to get automatically
  # config.cid = 'BRXX0198' # search by CID, deprecated and only for Brazil
end

# You also can change setup parameters directly
HG::Weather.api_key = 'my-key'
HG::Weather.locale = 'pt-br'
...
```

### Usage
```ruby
require 'hg/weather'

# You can set any search API parameter here
weather = HG::Weather.get(woeid: '2388327')

weather.key_status # => :empty (can be :empty, :valid or :invalid)

weather.city_name # => 'Cupertino'
weather.search_method # => 'woeid'
weather.woeid # => '2388327'

weather.condition
# Will return a HG::Weather::Condition object
# 62.6º F - 68 % - 4.0 miles/h - Sunrise: 06:01 - Sunset: 20:27 - Clear night

weather.condition.temperature # => 62.6º F
weather.condition.temperature.celsius # => 17.0
weather.condition.temperature.fahrenheit # => 62.6

# You can change default temperature format setting:
HG::Weather.temperature = :celsius
weather.condition.temperature # => 17.0º C

weather.condition.wind_speed # => 4.0 miles/h
weather.condition.wind_speed.km_h # => 6.44
weather.condition.wind_speed.miles_h # => 4.0

# You can change default speed format setting:
HG::Weather.speed = :km
weather.condition.wind_speed # => 6.44 km/h

weather.condition.humidity # => 68
weather.condition.description # => 'Partly cloudy'
weather.condition.slug # => :cloudly_night (see all slugs below)
weather.condition.currently # => :night (:day or :night)
weather.condition.datetime # => Time object (time of weather data)
weather.condition.sunrise # => Time object (time of sunrise)
weather.condition.sunset # => Time object (time of sunset)
weather.condition.is_day? # => false
weather.condition.is_night? # => true

weather.forecast
# Will return an array with HG::Weather::Condition object, with future weather conditions
# [07-16 - Max: 27.0º C - Min: 14.0º C - Fair day, 07-17 - Max: 24.0º C - M...

weather.forecast.each do |forecast|
  forecast.max_temperature.fahrenheit # => 80.0
  forecast.min_temperature.celsius # => 14.0
  forecast.description # => 'Fair day'
  forecast.slug # => :cloudly_day
  forecast.datetime # => Time object (time of weather data)
end

```

### Você é Brasileiro? (Are you Brazilian?)

Se você é brasileiro, basta configurar o idioma para 'pt-br' que todos os dados de data e hora, temperatura e velocidade são convertidos para o padrão brasileiro.

Você pode definir inline ou por bloco:

```ruby
require 'hg/weather'

# Definir por bloco:
HG::Weather.setup do |config|
  config.locale = 'pt-br'
end

# Definir inline:
HG::Weather.locale = 'pt-br'

```

#### Slug of condition

Slug can describe weather condition for your application. It is a simple representation of text description.

- storm
- snow
- hail
- rain
- fog
- clear_day
- clear_night
- cloud
- cloudly_day
- cloudly_night
- none_day (error to get, but it is day)
- none_night (error to get, but it is night)

## API Key and Status of Service

Some features like search by geolocation or geoIP requires an API Key.

You can generate your key on official webpage of HG Weather.
There you also find the status of API service.

[hgbrasil.com/weather](http://hgbrasil.com/status/weather/#chaves-de-api)

## Upcoming features

### Gem level

- Improvements on timezone
- Cache with Rails cache engine

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hg-weather.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
