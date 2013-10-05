# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'page_layout/version'

Gem::Specification.new do |spec|
  spec.name          = "page_layout"
  spec.version       = PageLayout::VERSION
  spec.authors       = ["Cyril Picard"]
  spec.email         = ["Cyril@picard.ch"]
  spec.description   = %q{Advanced page layout integration for SqlPager.}
  spec.summary       = %q{This is an awesome summary.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "rails", ">= 3.1"
  
end
