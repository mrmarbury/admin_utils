# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'admin-utils/version'

Gem::Specification.new do |s|
  s.name        = 'admin-utils'
  s.version     =  Au::Admin::Utils::VERSION
  s.authors     = 'TNG Technology Consulting GmbH'
  s.email       = 'sysadmin@tngtech.com'
  s.homepage    = 'https://confluence.tngtech.com'
  s.summary     = 'The Admin Utils'
  s.description = 'Fixed bugs and created new test for fixed bug'
  s.files         = Dir.glob('{lib,spec}/**/*') + %w[Rakefile Gemfile Gemfile.lock admin-utils.gemspec]
  s.test_files    = Dir.glob('spec/**/*')
  s.executables   = Dir.glob('*.rb')
  s.require_paths = %w[lib]
  s.required_ruby_version = '~> 1.9'
  s.add_dependency('log4r', '~> 1.1.10')
  s.add_dependency('rake', '~> 10.0.4')
  s.add_development_dependency('rspec', '~> 2.10')
  s.add_development_dependency('devver-construct', '~> 1.1.0')
  s.add_development_dependency('fake_ftp', '~> 0.0.9')
end
