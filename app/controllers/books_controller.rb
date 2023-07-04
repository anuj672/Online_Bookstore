class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    unless check_permissions?("view_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    if params[:sort] # sort using column headers
      @books = Book.order(params[:sort])
    elsif params[:author] # filters books#index based on input for author search
      @books = Book.where('author LIKE ?', "%#{params[:author]}%")
    elsif params[:rating] # filters books#index based on input for average rating number
      @books = Book.joins(:reviews).merge(Review.group(:book_id).having('avg(reviews.rating) >= ?',
                                                                        params[:rating].to_i))
    else
      @books = Book.all
    end

  end

  # GET /books/1 or /books/1.json
  def show
    unless check_permissions?("show_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    # shows associated reviews on book#show
    @book = Book.includes(:reviews).find(params[:id])

  end

  # GET /books/new
  def new
    unless check_permissions?("create_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    unless check_permissions?("edit_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
  end

  # POST /books or /books.json
  def create
    unless check_permissions?("create_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    unless check_permissions?("update_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    unless check_permissions?("delete_book")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:name, :author, :publisher, :price, :stock)
  end
end
