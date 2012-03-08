# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pure-sqlite/version"

Gem::Specification.new do |s|
  s.name        = "pure-sqlite"
  s.version     = PureSqlite::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Geihsler"]
  s.email       = ["chris@geihsler.net"]
  s.homepage    = ""
  s.summary     = %q{A gem that reads SQLite database files written entirely in ruby.}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
end
