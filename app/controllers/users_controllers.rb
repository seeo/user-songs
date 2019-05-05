class UsersController < ApplicationController
  def index
    unless current_user.artist?
      redirect_to :back, :alert => "Access denied."
    end
    @users = User.all
  end
end