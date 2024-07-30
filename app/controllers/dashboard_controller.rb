class DashboardController < ApplicationController
  before_action :require_login

  def index
    @security_logs = SecurityLogger.recent_logs(50)  # Fetch the 50 most recent log entries
  end
end