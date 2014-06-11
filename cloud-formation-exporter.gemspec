# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_formation/exporter/version'

Gem::Specification.new do |spec|
  spec.name          = "cloud-formation-exporter"
  spec.version       = CloudFormation::Exporter::VERSION
  spec.authors       = ["Mauricio Linhares"]
  spec.email         = ["mauricio.linhares@gmail.com"]
  spec.summary       = %q{Exports your AWS resources into cloud formation templates}
  spec.description   = %q{Exports your AWS resources into cloud formation templates}
  spec.homepage      = "https://github.com/mauricio/cloud-formation-exporter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'aws-sdk', '~> 1.42.0'
  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'activesupport', '~> 4.1.1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 3.0.0'
end
