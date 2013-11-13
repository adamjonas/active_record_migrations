require 'singleton'
require 'yaml'

module ActiveRecordMigrations
  class Configurations
    include Singleton

    attr_accessor :yaml_config, :database_configurations, :environment, :db_dir, :migrations_paths, :schema_format, :seed_loader

    def initialize
      @yaml_config = 'config/database.yml'
      @environment = ENV['db'] || Rails.env
      @db_dir = 'db'
      @migrations_paths = ['db/migrate']
      @schema_format = :ruby # or :sql
      @seed_loader = Rails.application
    end

    alias configure instance_eval

    def database_configuration
      @database_configurations ||= YAML.load(File.read @yaml_config)
    end
  end
end

