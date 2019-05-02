class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def signup
    @user = User.new
  end

  def login
    if logged_in?
      redirect_to root_url
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to login_url
  end

  def auth
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "You're Logged In!"
    else
      flash.alert = "Email or Password is incorect"
      redirect_to login_url
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :first_name, :last_name, :email, :password))

    respond_to do |format|
      if @user.password != params[:user][:password_verify]
        format.html { redirect_to signup_url, notice: 'Password is Not Match, Try Again' }
        format.json { render :show, status: :password_missmatch, location: @user }
      end

      if @user.save
        format.html { redirect_to signup_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(params.require(:user).permit(:email, :name, :first_name, :last_name, :bio, :password))
        format.html { redirect_to @user, notice: 'Unless you deliberately set fedora to delete the kernel every update you cannot have the old ones removed.User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
