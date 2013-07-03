module VagrantPlugins
  module Ec2setup
    class Config < Vagrant.plugin(2, :config)
      DEFAULT_VALUES = {
        key_pair_name:       'vagrant',
        region:              'ap-northeast-1',
        private_key_path:    '~/.ssh/id_rsa',
        security_group_name: 'default'
      }
      DEFAULT_VALUES.keys.each do |name|
        attr_accessor name
      end

      def initialize
        DEFAULT_VALUES.keys.each do |name|
          instance_variable_set("@#{name}", UNSET_VALUE)
        end
      end

      def finalize!
        DEFAULT_VALUES.each do |k, v|
          instance_variable_set("@#{k}", v) if instance_variable_get("@#{k}") == UNSET_VALUE
        end
      end
    end
  end
end
