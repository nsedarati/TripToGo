class UsersController < ApplicationController
  # before_action :require_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
    # before_action :admin_only, except: [:show, :edit]
 
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    unless current_user.super_admin? || current_user.website_admin?
      unless @user == current_user
      redirect_to '/', notice => "Access Denied."
    end
  end
  end

  # GET /users/new
  def new
    @user = User.new
  end

 

  # POST /users
  # POST /users.json
  def create
     # byebug
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
    
      redirect_to(@user, notice: 'User created')
      
        format.html { redirect_to '/', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else

        format.html { redirect_to '/signup_path' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
     @user = User.find(params[:id])
     @user.update(user_params)
     if @user.save
      redirect_to users_path(current_user)
      flash[:notice] = "successfully Updated!"
    else

      redirect_to users_path
      flash[:notice] = "Unable to update user."
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 
    def edit
    @user = User.find(params[:id])
  end
 
  private

  def admin_only
    unless current_user.super_admin? || current_user.website_admin?
      redirect_to '/', :alert => "Access denied."
    end
    
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :access_level, :image)
  end
end
