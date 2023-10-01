if defined?(Rack::MiniProfiler)
  Rack::MiniProfiler.config.tap do |config|
    config.enable_hotwire_turbo_drive_support = true
  end
end
