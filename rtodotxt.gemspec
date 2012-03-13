# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rtodotxt/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Philipp Fehre"]
  gem.email         = ["philipp.fehre@googlemail.com"]
  gem.description   = %q{TodoTXT command in Ruby}
  gem.summary       = %q{Use a todotxt formatted file in ruby}
  gem.homepage      = "http://github.com/sideshowcoder/rtodotxt"

  # Development dependencies
  gem.add_development_dependency "rspec", "~> 2.8"
  gem.add_development_dependency "autotest", "~> 4.4.6"
  gem.add_development_dependency "autotest-fsevent", "~> 0.2.8"
  gem.add_development_dependency "autotest-growl", "~> 0.2.16"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rtodotxt"
  gem.require_paths = ["lib"]
  gem.version       = Rtodotxt::VERSION
end
