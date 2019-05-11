class PasswordsController < ApplicationController
  def new

  end

  def edit
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.set_password_reset
      UserMailer.password_reset(user).deliver_now
    end
    flash[:warning] = 'Password reset sent if email exists'
    redirect_to root_path
  end

end
