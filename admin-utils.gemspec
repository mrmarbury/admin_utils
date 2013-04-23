# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'admin-utils/version'

Gem::Specification.new do |s|
  s.name        = 'admin-utils'
  s.version     =  Au::Admin::Utils::VERSION
  s.authors     = 'TNG Technology Consulting GmbH'
  s.email       = 'siemens-sen-ccs@tngtech.com'
  s.homepage    = 'http://ccs.global-intra.net/confluence'
  s.summary     = 'The CCS Admin Utils'
  s.description = 'New Release Installer is working with this gem'
  s.files         = Dir.glob('{lib,spec}/**/*') + %w[Rakefile Gemfile Gemfile.lock admin-utils.gemspec]
  s.test_files    = Dir.glob('spec/**/*')
  s.executables   = Dir.glob('*.rb')
  s.require_paths = %w[lib]
  s.required_ruby_version = '~> 1.9'
  s.add_dependency('log4r', '~> 1.1.10')
  s.add_development_dependency('rspec', '~> 2.10')
  s.add_development_dependency('rake', '~> 0.9.2.2')
  s.add_development_dependency('devver-construct', '~> 1.1.0')
  s.add_development_dependency('fake_ftp', '~> 0.0.9')
end
