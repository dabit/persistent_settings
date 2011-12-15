# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "persistent_settings"

Gem::Specification.new do |s|
  s.name        = "persistent_settings"
  s.version     = Settings::VERSION
  s.authors     = ["David Padilla"]
  s.email       = ["david@crowdint.com"]
  s.homepage    = ""
  s.summary     = %q{Simple global Settings class for ActiveRecord based applications}
  s.description = %q{Simple global Settings class for ActiveRecord based applications}

  s.rubyforge_project = "persistent_settings"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '~> 3'
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3", "~> 1.3"
end
