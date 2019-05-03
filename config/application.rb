require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Crypto
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('app', 'commands', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'queries', '{*/}')]
    config.active_record.raise_in_transactional_callbacks = true
  end
end
