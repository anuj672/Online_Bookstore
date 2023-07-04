class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]



  # GET /reviews or /reviews.json
  def index
    unless check_permissions?("view_review")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    if params[:book] # filters reviews#index based on input for book search
      @reviews = Review.joins(:book).where('name LIKE ?', "%#{params[:book]}%")
    elsif params[:user] # filters reviews#index based on input for username search
      @reviews = Review.joins(:user).where('username LIKE ?', "%#{params[:user]}%")
      if @reviews.size == 0 && "administrator".include?(params[:user].downcase) # considers if review is written by admin
        @reviews = Review.where('admin_id IS NOT NULL AND user_id IS NULL')
      end
    elsif
      @reviews = Review.all
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    unless check_permissions?("show_review")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
  end

  # GET /reviews/new
  def new
    unless check_permissions?("create_review")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @review = Review.new
    if @book.nil? && params[:book_id]
      @book = Book.find(params[:book_id])
    end
  end

  # GET /reviews/1/edit
  def edit
    # if not admin, can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("edit_review") ||
      (check_permissions?("edit_review") && !current_user.nil? && current_user.id != @review.user_id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # POST /reviews or /reviews.json
  def create
    unless check_permissions?("create_review")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @review = Review.new(review_params)

    @book = Book.find(params[:review][:book_id])

    respond_to do |format|
      if @review.save
        format.html { redirect_to reviews_url, notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    # if not admin, can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("update_review") ||
      (check_permissions?("update_review") && !current_user.nil? && current_user.id != @review.user_id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    unless check_permissions?("delete_review")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:book_id, :user_id, :rating, :review, :admin_id)
    end
end
