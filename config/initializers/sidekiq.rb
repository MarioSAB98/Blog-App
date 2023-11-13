Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://172.18.0.2:6379/0' }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://172.18.0.2:6379/0' }
  end