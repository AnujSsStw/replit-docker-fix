require 'singleton'

class SecurityLogger
  include Singleton

  def initialize
    @logs = []
  end

  def self.log_event(event_type:, message:, user_id: nil, ip_address: nil, details: nil)
    instance.log_event(event_type: event_type, message: message, user_id: user_id, ip_address: ip_address, details: details)
  end

  def log_event(event_type:, message:, user_id: nil, ip_address: nil, details: nil)
    log_entry = {
      timestamp: Time.now,
      event_type: event_type,
      message: message,
      user_id: user_id,
      ip_address: ip_address,
      details: details
    }
    @logs.unshift(log_entry)
    @logs.pop if @logs.size > 1000  # Keep only the latest 1000 logs

    Rails.logger.info("Security Event: #{log_entry.to_json}")
  end

  def self.recent_logs(limit = 50)
    instance.recent_logs(limit)
  end

  def recent_logs(limit = 50)
    @logs.take(limit)
  end
end