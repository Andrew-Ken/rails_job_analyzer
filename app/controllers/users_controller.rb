class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:email])
    @user.password = params[:password]
    @user.password_confirmation = params[:confirmpassword]
    @user.save
    redirect_to jobs_path, :notice => "Signed up!"
  rescue => e
    render text: e
  end
end
