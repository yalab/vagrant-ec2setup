require 'aws-sdk'
require 'net/ssh'

module VagrantPlugins
  module Ec2setup
    class Command < Vagrant.plugin("2", :command)
      def usage
        puts <<-EOS.gsub(/^ {10}/, '')
          You must set AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID.
          For example into your ~/.bashrc

            export AWS_ACCESS_KEY_ID="Your Aws Access Key"
            export AWS_SECRET_ACCESS_KEY="Your Aws Access Token"
        EOS
        exit
      end

      def execute
        @config = @env.config_global.ec2setup
        ENV['AWS_ACCESS_KEY_ID'] || usage
        ENV['AWS_SECRET_ACCESS_KEY'] || usage
        generate_key_pair
        generate_security_group
      end

      def region
        region_name = @config.region
        return @region if @region
        @region = ::AWS::EC2.new.regions[region_name].tap{|region|
          raise "No such region #{region_name}." unless region.exists?
        }
      end

      def generate_key_pair
        key_pair_name    = @config.key_pair_name
        private_key_path = @config.private_key_path
        @key_pair ||= if File.exists?(private_key_path) && (key = region.key_pairs[key_pair_name]).exists?
                        key
                      else
                        region.key_pairs.create(key_pair_name).tap{|k|
                          File.open(private_key_path, 'w'){|f| f.write(k.private_key) }
                        }
                      end
      end

      def generate_security_group
        security_group_name = @config.security_group_name
        return if region.security_groups.filter('group-name', security_group_name).count > 0
        security_group = region.security_groups.create(security_group_name)
        [22, 80, 443].each do |port|
          security_group.authorize_ingress(:tcp, port, "0.0.0.0/0")
        end
      end
    end
  end
end
