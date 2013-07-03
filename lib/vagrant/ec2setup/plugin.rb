module VagrantPlugins
  module Ec2setup
    class Plugin < Vagrant.plugin("2")
      name "ec2setup"
      description <<-DESC.gsub(/ {8}/, '')
        Setup your ec2 server.
      DESC

      config("ec2setup") do
        require_relative 'config'
        Config
      end

      command("ec2setup") do
        require_relative 'command'
        Command
      end
    end
  end
end
