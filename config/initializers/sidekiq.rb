# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://127.0.0.1:6379/10' }

  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://127.0.0.1:6379/10' }

  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end
