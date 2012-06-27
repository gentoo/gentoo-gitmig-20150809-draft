# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "aws-sdk"
  s.version = "VERSION"
  s.homepage = "http://aws.amazon.com/sdkforruby"
  s.require_paths = ["lib"]
  s.summary = "AWS SDK for Ruby"

  s.add_runtime_dependency(%q<uuidtools>, [">= 2.1"])
  s.add_runtime_dependency(%q<httparty>, [">= 0.7"])
  s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.4"])
  s.add_runtime_dependency(%q<json>, [">= 1.4"])
end
