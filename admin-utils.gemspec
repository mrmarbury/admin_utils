# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'admin-utils/version'

Gem::Specification.new do |s|
  s.name        = 'admin-utils'
  s.version     =  Au::Admin::Utils::VERSION
  s.authors     = 'Stefan Wendler'
  s.email       = 'stefan@binarysun.de'
  s.homepage    = 'https://github.com/mrmarbury/admin_utils'
  s.licenses    = 'Apache-2.0'
  s.summary     = 'The Admin Utils'
  s.description = 'Some basic utilities that I need often when writing Ruby Code'
  s.files         = Dir.glob('{lib,spec}/**/*') + %w[Rakefile Gemfile Gemfile.lock admin-utils.gemspec]
  s.test_files    = Dir.glob('spec/**/*')
  s.executables   = Dir.glob('*.rb')
  s.require_paths = %w[lib]
  s.required_ruby_version = '~> 2.4'
  s.add_dependency('log4r')
  s.add_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('devver-construct')
  s.add_development_dependency('fake_ftp')
end
