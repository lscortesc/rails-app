class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_articles = @user.articles.paginate(page:  params[:page], per_page: 20)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, flash: { success: "Welcome to the blog #{@user.username}" } }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, flash: { danger: "We can not register the user #{@user.username}" } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, flash: { success: "Welcome to the blog #{@user.username}" } }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, flash: { danger: "We can not register the user #{@user.username}" } }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if !logged_in? || (current_user != @user && !current_user.admin?)
        respond_to do |format|
          format.html { redirect_to users_path, flash: { danger: 'You can not edit this user.' } }
          format.json { head :no_content, status: :unprocessable_entity }
        end
      end
    end

    def require_admin
      if logged_in? && !current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, flash: { danger: 'Only admin users can perform that action.' } }
          format.json { head :no_content, status: :unprocessable_entity }
        end
      end
    end
end
