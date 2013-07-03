require 'aws-sdk'
require 'net/ssh'

module VagrantPlugins
  module Ec2Setup
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
        ENV['AWS_ACCESS_KEY_ID'] || usage
        ENV['AWS_SECRET_ACCESS_KEY'] || usage
        generate_key_pair
        generate_security_group
      end

      def region
        return @region if @region
        name ||= ENV['AWS_REGION'] || 'ap-northeast-1'
        @region = ::AWS::EC2.new.regions[name].tap{|region|
          raise "No such region #{region.name}." unless region.exists?
        }
      end

      def generate_key_pair
        @key_pair ||= if (key = region.key_pairs[KEY_PAIR_NAME]).exists?
                        key
                      else
                        region.key_pairs.create(KEY_PAIR_NAME).tap{|k|
            File.open(PRIVATE_KEY_PATH, 'w'){|f| f.write(k.private_key) }
          }
                      end
      end

      def generate_security_group
        return if region.security_groups.filter('group-name', SECURITY_GROUP_NAME).count > 0
        security_group = region.security_groups.create(SECURITY_GROUP_NAME)
        [22, 80, 443].each do |port|
          security_group.authorize_ingress(:tcp, port, "0.0.0.0/0")
        end
      end
    end
  end
end
