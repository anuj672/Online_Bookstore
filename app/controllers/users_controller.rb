class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :authorized, only: [:new, :create]


  # GET /users or /users.json

  def index
    unless check_permissions?("view_user")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end

    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    # if not admin, ensures that user can only see their own profile
    if !check_permissions?("show_user") ||
      (check_permissions?("show_user") && !current_user.nil? && current_user.id != @user.id)
       redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # GET /users/new
  def new
    if !current_user.nil? && !check_permissions?("create_user")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @user = User.new
  end

  # GET /users/1/edit

  def edit
    # if not admin, ensures that user can only edit their own profile
    if !check_permissions?("edit_user") ||
      (check_permissions?("edit_user") && !current_user.nil? && current_user.id != @user.id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # POST /users or /users.json
  def create
    if !current_user.nil? && !check_permissions?("create_user")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @cart = Cart.create(user_id: @user.id)
        unless current_admin
          session[:user_id] = @user.id
          format.html { redirect_to root_url, notice: "Account was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to user_url(@user), notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    unless check_permissions?("update_user")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    respond_to do |format|
      #params[:user].delete(:password) if params[:user][:password].blank?
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # if not admin, ensures that user can only delete their own profile
    if !check_permissions?("delete_user") ||
      (check_permissions?("delete_user") && !current_user.nil? && current_user.id != @user.id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    session[:user_id] = nil
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "User was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username,:password, :name, :email, :address, :credit_card_number, :phone_number)
  end
end