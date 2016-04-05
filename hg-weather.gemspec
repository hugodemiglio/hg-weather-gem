# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hg/weather/version'

Gem::Specification.new do |spec|
  spec.name          = "hg-weather"
  spec.version       = HG::Weather::VERSION
  spec.authors       = ["Hugo Demiglio"]
  spec.email         = ["hugodemiglio@gmail.com"]

  spec.description   = %q{Get current and forecast weather using HG Weather API.}
  spec.summary       = %q{Simple gem to get weather data from HG Weather.}
  spec.homepage      = 'http://hgbrasil.com/weather'
  spec.license       = 'MIT'

  spec.files         = `git ls-files lib`.split($/)
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
