# Vagrant::Ec2Setup

Setup security group ssh key as single web applicatoin server on Amazon EC2. 

## Installation

Add this line to your application's Gemfile:

    gem 'vagrant-ec2_setup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vagrant-ec2_setup

## Usage

Edit your Vagrantfile like this

```
Vagrant.configure("2") do |config|
  (...)
  config.ec2setup.key_pair_name       = 'vagrant-aws'
  config.ec2setup.region              = 'ap-northeast-1'
  config.ec2setup.private_key_path    = "#{ENV['HOME']}/.ssh/vagrant-aws.pem"
  config.ec2setup.security_group_name = 'webapp'


```

Then use it

```
$ vagrant ec2setup
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
