require_relative "boot"

require "rails/all"

# ↓ ここにあった Solid系 Engine の require をすべて削除しました

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

    # Rails 8 が自動で Solid Queue 等を使おうとするのを防ぐ
    config.active_job.queue_adapter = :async
    config.cache_store = :memory_store
  end
end