require 'open-uri'
require 'json'

require 'hg/weather/version'
require 'hg/weather/data'

module HG
  module Weather
    HOST_NAME = '://api.hgbrasil.com/weather'

    class << self
      # API Key
      attr_accessor :api_key

      # Locale
      attr_accessor :locale

      # Default temperature format
      attr_accessor :temperature

      # Default speed format
      attr_accessor :speed

      # API Key status
      attr_reader :api_key_status

      # Use SSL to access the API
      attr_accessor :use_ssl

      # Use Rails cache for recieved data (realy recommended)
      attr_accessor :use_rails_cache

      attr_accessor :cid, :woeid, :city_name, :latitude, :longitude, :client_ip
      @@client_ip = :remote
    end

    def self.locale
      @locale || :en
    end

    def self.temperature
      @temperature || Locale.get_format(:temperature)
    end

    def self.speed
      @speed || Locale.get_format(:speed)
    end

    def self.use_ssl
      @use_ssl || true
    end

    def self.setup(&block)
      yield self
    end

    def self.get(options = {})
      to_request = {
        lat: options[:latitude], lon: options[:longitude],
        cid: options[:cid], city_name: options[:city_name],
        user_ip: options[:client_ip], woeid: options[:woeid]
      }.delete_if{|k,v| v.nil?}

      process(to_request)
    end

    def self.process params
      params = defaults.merge(params).delete_if{|k,v| v.nil?}

      return HG::Weather::Data.new(params, HOST_NAME, self.use_ssl)
    end

    def self.defaults
      {
        lat: self.latitude,
        lon: self.longitude,
        user_ip: self.client_ip,
        cid: self.cid,
        woeid: self.woeid,
        city_name: self.city_name,
        key: self.api_key,
        locale: self.locale,
        format: :json,
        sdk_version: "ruby_#{HG::Weather::VERSION}"
      }
    end

  end
end
