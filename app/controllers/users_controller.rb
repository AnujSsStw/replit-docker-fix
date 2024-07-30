class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      SecurityLogger.log_event(
        event_type: 'user_registration',
        message: 'New user registered',
        user_id: @user.id,
        ip_address: request.remote_ip
      )
      redirect_to dashboard_path, notice: 'Account created successfully!'
    else
      SecurityLogger.log_event(
        event_type: 'registration_failure',
        message: 'User registration failed',
        user_id: nil,
        ip_address: request.remote_ip,
        details: @user.errors.full_messages.join(', ')
      )
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end