class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      SecurityLogger.log_event(
        event_type: 'authentication_success',
        message: 'User logged in',
        user_id: user.id,
        ip_address: request.remote_ip
      )
      redirect_to dashboard_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid email/password combination'
      SecurityLogger.log_event(
        event_type: 'authentication_failure',
        message: 'Failed login attempt',
        user_id: nil,
        ip_address: request.remote_ip,
        details: "Email: #{params[:session][:email]}"
      )
      render :new
    end
  end

  def destroy
    SecurityLogger.log_event(
      event_type: 'user_logout',
      message: 'User logged out',
      user_id: current_user.id,
      ip_address: request.remote_ip
    )
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end