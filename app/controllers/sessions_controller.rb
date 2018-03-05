class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username].downcase)

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to user_path(user), flash: { success: 'You have successfully login.' } }
        format.json { render :new, status: :created, location: users_path(user) }
      else
        format.html { redirect_to login_path, flash: { danger: 'There was something wrong with your login information' } }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      session[:user_id] = nil
      format.html { redirect_to root_path, flash: { success: 'You have successfully logout.' } }
      format.json { render :new, status: :ok, location: root_path }
    end
  end
end
