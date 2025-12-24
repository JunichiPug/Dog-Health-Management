require "active_support/core_ext/integer/time"

Rails.application.configure do
  # =====================================================================
  # 基本設定
  # =====================================================================
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # 静的ファイルの設定
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # =====================================================================
  # ログ設定（Renderのログで見やすくするために重要）
  # =====================================================================
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"

  # =====================================================================
  # ホスト許可（Render用設定）
  # =====================================================================
  config.hosts << ".onrender.com"
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }

  # =====================================================================
  # Solid 関連の設定
  # =====================================================================
  # アダプタの指定のみ行います。
  # 接続先は database.yml の「databases:」設定が自動的に使用されます。
  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue

  # =====================================================================
  # その他の設定
  # =====================================================================
  config.active_storage.service = :local
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # メーラー設定
  config.action_mailer.default_url_options = { host: "dog-health-management.onrender.com" }
end