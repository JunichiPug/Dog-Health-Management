require "active_support/core_ext/integer/time"

Rails.application.configure do
  # =====================================================================
  # 基本設定
  # =====================================================================
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # =====================================================================
  # ログ設定
  # =====================================================================
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"

  # =====================================================================
  # ホスト許可
  # =====================================================================
  config.hosts << ".onrender.com"

  # =====================================================================
  # 【超重要】データベース依存を完全に切り離す設定
  # =====================================================================
  # キャッシュにDBを使わない（Solid Cacheをスキップ）
  config.cache_store = :memory_store

  # キューにDBを使わない（Solid Queueをスキップ）
  config.active_job.queue_adapter = :async

  # Rails 8 で Solid系 Gem が自動起動するのを防ぐ
  config.solid_cache.connects_to = nil if config.respond_to?(:solid_cache)
  config.solid_queue.connects_to = nil if config.respond_to?(:solid_queue)

  # =====================================================================
  # その他の設定
  # =====================================================================
  config.active_storage.service = :local
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = { host: "dog-health-management.onrender.com" }
end