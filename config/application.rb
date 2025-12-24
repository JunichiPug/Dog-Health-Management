require_relative "boot"

require "rails/all"

# Rails 8 の新しいエンジンを明示的にロード（ビルドエラー回避用）
require "solid_cable/engine"
require "solid_cache/engine"
require "solid_queue/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # 日本時間の設定
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local

    # Configuration for the application, engines, and railties goes here.
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
