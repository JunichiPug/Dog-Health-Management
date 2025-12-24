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
  # ホスト許可（Renderでの「Timed out」を防ぐ最重要設定）
  # =====================================================================
  # 全ての .onrender.com ドメインからのアクセスを許可
  config.hosts << ".onrender.com"
  # ヘルスチェックパス（/up）をホストチェックから除外
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }

  # =====================================================================
  # Solid 関連の設定（Rails 8 標準）
  # =====================================================================
  # キャッシュ: Gemfileに合わせてSolid Cacheを使用
  config.cache_store = :solid_cache_store

  # 非同期処理: Solid Queueを使用
  config.active_job.queue_adapter = :solid_queue

  # データベース接続先の設定（database.ymlと連動）
  config.solid_cache.connects_to = { database: { writing: :cache } }
  config.solid_queue.connects_to = { database: { writing: :queue } }
  config.solid_cable.connects_to = { database: { writing: :cable } }

  # =====================================================================
  # その他の設定
  # =====================================================================
  config.active_storage.service = :local
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # SSL（Render側でSSL化されるため一旦コメントアウトしていますが、本番運用ではtrue推奨）
  # config.force_ssl = true

  # メーラー設定（必要に応じて host を変更してください）
  config.action_mailer.default_url_options = { host: "dog-health-management.onrender.com" }
end
