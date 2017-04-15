# frozen_string_literal: true
# Provides access to the Environment Config
#
# Usage:
#
# EnvConfig.Environment         Returns the current config environment
# EnvConfig.config              Returns the whole config hash
# EnvConfig['some_key']         Returns the value of key 'some_key' from current config in config.yml
# EnvConfig.some['key']   Is equivalent to EnvConfig['some']['key']

require 'singleton'
require 'yaml'

class EnvConfig
  include Singleton
  attr_reader :config, :environment

  def initialize
    config_yaml = File.join(Dir.pwd, 'config.yml')
    raise "No config.yml found" unless File.exist? config_yaml
    config_file = YAML.load(File.open(config_yaml))

    # Get config setting from environment. Should be passed in like CONFIG=local from command line (see rakefile)
    # Defaults to local if nothing passed in
    @environment = ENV['CONFIG']

    if @environment.nil?
      @environment = config_file.fetch('defaults').fetch('default_config')
      abort "Exiting: No CONFIG supplied from command line, and no default_config found in config.yml" if @environment.nil?
    end

    @config = config_file[@environment]
  end

  # Allow calls like EnvConfig['some_key']
  def self.[](key_name)
    instance.value_for key_name
  end

  # Allow calls like EnvConfig.some_key
  def self.method_missing(name, *args, &block)
    instance.config[name.to_s].nil? ? super : instance.config[name.to_s]
  end

  def self.respond_to_missing?(method_name, include_private = false)
    instance.config[name.to_s].nil? ? super : true
  end

  # Allow calls like EnvConfig.some_key
  def self.respond_to?(name)
    instance.config[name.to_s].nil? ? super : true
  end

  def value_for(key_name)
    raise "There is no key '#{key_name}' for the config '#{@environment}' in config.yml" if @config[key_name].nil?
    @config[key_name]
  end
end
