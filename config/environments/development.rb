Rails.application.configure do
    # ... other configurations ...
    config.eager_load = true
    config.active_storage.service = :local
    config.web_console.allowed_ips = ['127.0.0.1', '::1', '172.17.0.0/16']
    config.assets.compile = true

    # ... other configurations ...
end