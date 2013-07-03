# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/ec2setup/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-ec2setup"
  spec.version       = Vagrant::Ec2setup::VERSION
  spec.authors       = ["yalab"]
  spec.email         = ["rudeboyjet@gmail.com"]
  spec.description   = "Automation setup security group, ssh key on EC2."
  spec.summary       = "This gem is a vagrant plugin for provider ec2 environment setup. SSH key or Security group for web application."
  spec.homepage      = "https://github.com/yalab/vagrant-ec2_setup"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
