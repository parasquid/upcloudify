# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upcloudify/version'

Gem::Specification.new do |spec|
  spec.name          = "upcloudify"
  spec.version       = Upcloudify::VERSION
  spec.authors       = ["parasquid"]
  spec.email         = ["parasquid@gmail.com"]
  spec.description   = %q{Upcloudify simplifies the process for uploading
                          attachments to the cloud and emailing the recipient
                          a link to that attachment}
  spec.summary       = %q{Upload a file to the cloud and email a link for the attachment}
  spec.homepage      = ""
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'gem_config'
  spec.add_dependency 'pony'
  spec.add_dependency 'zippy'
  spec.add_dependency 'zip-zip'
  spec.add_dependency 'fog'

end
