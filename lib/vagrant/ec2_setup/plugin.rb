module VagrantPlugins
  module Ec2Setup
    class Plugin < Vagrant.plugin("2")
      name "ec2-setup"
      description <<-DESC.gsub(/ {8}/, '')
        Setup your ec2 server.
      DESC

      command("ec2-setup") do
        require File.expand_path("../command", __FILE__)
        Command
      end
    end
  end
end
