# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tech_docs_gem/version"

Gem::Specification.new do |spec|
  spec.name          = "tech_docs_gem"
  spec.version       = TechDocsGem::VERSION
  spec.authors       = ["Tijmen Brommet"]
  spec.email         = ["tijmen@gmail.com"]

  spec.summary       = %q{Write a short summary, because Rubygems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "middleman", "~> 4.0"
  spec.add_dependency "middleman-autoprefixer", "~> 2.7.0"
  spec.add_dependency "middleman-compass", ">= 4.0.0"
  spec.add_dependency "middleman-livereload"
  spec.add_dependency "middleman-sprockets", "~> 4.0.0"
  spec.add_dependency "middleman-syntax", "~> 3.0.0"
  spec.add_dependency "nokogiri"
  spec.add_dependency "redcarpet", "~> 3.3.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
