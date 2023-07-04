class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show edit update destroy ]

  # GET /cart_items or /cart_items.json
  def index
    unless check_permissions?("view_cart_item")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    # ensures users can only see their own cart items and not other users' cart items
    if current_user
      @cart_items = CartItem.where(user: current_user.id)
    else
      @cart_items = CartItem.all
    end

  end

  # GET /cart_items/1 or /cart_items/1.json
  def show
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("show_cart_item") ||
      (check_permissions?("show_cart_item") && !current_user.nil? && current_user.id != @cart_item.user)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # GET /cart_items/new
  def new
    unless check_permissions?("create_cart_item")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @cart_item = CartItem.new
    # automatically sets book_id
    if @book.nil? && params[:book_id]
      @book = Book.find(params[:book_id])
    end
  end

  # GET /cart_items/1/edit
  def edit
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("edit_cart_item") ||
      (check_permissions?("edit_cart_item") && !current_user.nil? && current_user.id != @cart_item.user)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @book = Book.find(@cart_item.book_id)
    @cart = Cart.find(@cart_item.cart_id)
    # ensures cart_item can only be kept in cart if book is available for purchase
    if @book.stock == 0
      redirect_to cart_path(@cart), flash: {alert: "#{@book.name} is no longer available for purchase. Please remove this book from your cart."}
    end
  end

  # POST /cart_items or /cart_items.json
  def create
    unless check_permissions?("create_cart_item")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @cart_item = CartItem.new(cart_item_params)
    @book = Book.find(params[:cart_item][:book_id])
    @cart_item.cart = Cart.find(current_user.cart.id) # automatically sets cart
    @cart_item.book_id = @book.id # automatically sets book_id
    @cart_item.user = current_user.id # automatically sets user

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_item_url(@cart_item), notice: "Cart item was successfully created." }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_items/1 or /cart_items/1.json
  def update
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("update_cart_item") ||
      (check_permissions?("update_cart_item") && !current_user.nil? && current_user.id != @cart_item.user)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to cart_url(@cart_item.cart), notice: "Cart item was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1 or /cart_items/1.json
  def destroy
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("delete_cart_item") ||
      (check_permissions?("delete_cart_item") && !current_user.nil? && current_user.id != @cart_item.user)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_url(@cart_item.cart), notice: "Cart item was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :book_id, :user, :quantity, :total_price)
    end
end
