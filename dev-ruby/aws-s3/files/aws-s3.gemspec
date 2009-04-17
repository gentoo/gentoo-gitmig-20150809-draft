# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
    s.name              = 'aws-s3'
    s.version           = '@VERSION@'
    s.summary           = "Client library for Amazon's Simple Storage Service's REST API"
    s.description       = s.summary
    s.email             = 'marcel@vernix.org'
    s.author            = 'Marcel Molina Jr.'
    s.homepage          = 'http://amazon.rubyforge.org'
    s.rubyforge_project = 'amazon'
    
    s.add_dependency 'xml-simple'
    s.add_dependency 'builder'
    s.add_dependency 'mime-types'
  end
