# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/assert_changes/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-assert_changes"
  spec.version       = Minitest::AssertChanges::VERSION
  spec.authors       = ["Genadi Samokovarov"]
  spec.email         = ["gsamokovarov@gmail.com"]

  spec.summary       = "Introduces assert_changes and assert_no_changes to Minitest."
  spec.description   = "Introduces assert_changes and assert_no_changes to Minitest."
  spec.homepage      = "https://github.com/gsamokovarov/minitest-assert_changes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
