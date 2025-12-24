require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # ログ出力
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # ホスト許可
  config.hosts << ".onrender.com"

  # 【重要】一旦、DBを使わないキャッシュとキューに変更します
  config.cache_store = :memory_store
  config.active_job.queue_adapter = :async

  config.active_storage.service = :local
  config.i18n.fallbacks = true
  
  config.action_mailer.default_url_options = { host: "dog-health-management.onrender.com" }
end