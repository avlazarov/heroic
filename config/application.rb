require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Heroic
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.generators do |g|
      g.test_framework :rspec
    end

    custom_config = YAML.load_file("#{::Rails.root}/config/config.yml")[::Rails.env]

    config.items = {'prefixes' => custom_config['item_prefixes'], 
                    'suffixes' => custom_config['item_suffixes'],
                    'types'    => custom_config['item_types']}

    config.inventory_capacity      = custom_config['inventory_capacity']
    config.experience_per_level    = custom_config['experience_per_level']
    config.experience_percent_lost = custom_config['experience_percent_lost']
    config.potion_heal_percent     = custom_config['potion_heal_percent']
  end
end
