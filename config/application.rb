require_relative "boot"

require "rails/all"

# Rails 8 の新機能を強制的にロードし、ビルドエラーを防ぐ
require "solid_cable/engine"
require "solid_cache/engine"
require "solid_queue/engine"

# Gemfileに記載されたGemをロード
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Rails 8.1 のデフォルト設定
    config.load_defaults 8.1

    # 日本時間の設定
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local

    config.autoload_lib(ignore: %w[assets tasks])
  end
end
