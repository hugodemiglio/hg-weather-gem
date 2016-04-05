# HG::Weather

Now you can simply get current and forecast data from HG Weather API directly on your Ruby Application.

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

You can configure all of HG Weather params, but not of them are required.

```ruby
require 'hg/weather'

HG::Weather.setup do |config|
  # You can generate your key on hgbrasil.com/weather
  # Key is required for search by name, geolocation or IP.
  config.api_key = 'my-key'

  # Use SSL on request, default and recommended is true
  config.use_ssl = true

  # Coming... If you are using Rails, request can be cached on cache engine
  config.use_rails_cache = true

  # config.cid = 'BRXX0198' # set default City ID
  # config.city_name = 'Ribeirao Preto' # set city name for search
  # config.latitude = -41.0 # set latitude
  # config.longitude = -41.0 # set longitude
  # config.client_ip = :remote # your IP or 'remote' to get automatically
end

# You also can change setup parameters directly
HG::Weather.api_key = 'my-key'
```

### Usage
```ruby
require 'hg/weather'

# You can set any search API parameter here
weather = HG::Weather.get(cid: 'BRXX0198')

weather.key_status # => :empty (can be :empty, :valid or :invalid)

weather.city_name # => 'Ribeirão Preto'
weather.search_method # => 'cid'
weather.cid # => 'BRXX0198'

weather.condition
# Will return a HG::Weather::Data object, with current weather data

weather.condition.temperature # => HG::Weather::Temperature
weather.condition.temperature.celsius # => 23.0
weather.condition.temperature.fahrenheit # => 73.4

weather.condition.wind_speed # => HG::Weather::Speed
weather.condition.wind_speed.km_h # => 11.27
weather.condition.wind_speed.miles_h # => 7.002

weather.condition.humidity # => 83
weather.condition.description # => 'Parcialmente nublado' (on native country location)
weather.condition.slug # => :cloudly_night
weather.condition.currently # => :night (:day or :night)
weather.condition.datetime # => Time object (time of weather data)
weather.condition.sunrise # => Time object (time of sunrise)
weather.condition.sunset # => Time object (time of sunset)

weather.forecast
# Will return an array with HG::Weather::Data object, with future weather conditions

weather.forecast.each do |forecast|
  forecast.max_temperature.celsius # => 31.0
  forecast.min_temperature.celsius # => 20.0
  forecast.description # => 'Parcialmente nublado' (on native country location)
  forecast.slug # => :cloudly_night
  forecast.datetime # => Time object (time of weather data)
end

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hg-weather.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
