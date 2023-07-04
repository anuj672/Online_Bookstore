class CartsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_cart, only: %i[ show edit update destroy ]

  # GET /carts or /carts.json
  def index
    if !check_permissions?( "view_cart")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    # ensures users can only see their own cart and not other users' carts
    if current_user
      @carts = Cart.where(user_id: current_user.id)
    else
      @carts = Cart.all
    end
  end

  # GET /carts/1 or /carts/1.json
  def show
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("show_cart") ||
      (check_permissions?("show_cart") && !current_user.nil? && current_user.id != @cart.user_id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # GET /carts/new
  def new
    if !check_permissions?( "new_cart")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("edit_cart") ||
      (check_permissions?("edit_cart") && !current_user.nil? && current_user.id != @cart.user_id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # POST /carts or /carts.json
  def create
    if !check_permissions?( "create_cart")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @cart = Cart.new(cart_params)
    @cart.user_id = current_user.id
    # @cart.credit_card_number = current_user.credit_card_number
    # @cart.address = current_user.address
    # @cart.phone_number = current_user.phone_number

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    # this action completes purchase of items in a cart
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("update_cart") ||
      (check_permissions?("update_cart") && !current_user.nil? && current_user.id != @cart.user_id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    respond_to do |format|
      if @cart.update(cart_params)
        @cart.cart_items.each { |cart_item|
          @book = Book.find(cart_item.book_id)
          # If quantity requested in cart is available in book's stock, creates a transaction for each cart item
          # and updates corresponding book's stock. If quantity requested is not available, purchase is halted.
          if @book.stock >= cart_item.quantity
            Transaction.create(book_id: cart_item.book_id, user_id: current_user.id,
                                                               credit_card_number: @cart.credit_card_number,
                                                               address: @cart.address, phone_number: @cart.phone_number,
                                                               quantity: cart_item.quantity,
                                                               total_price: cart_item.total_price, transaction_number:
                                                                 Array.new(10){[*"0".."9"].sample}.join) &&
            Book.where(id: cart_item.book_id).update(stock: cart_item.book.stock - cart_item.quantity)
            cart_item.delete
          else
            redirect_to cart_path(@cart), flash: {alert: "#{cart_item.book.name} in your cart is no longer available at the quantity requested. Please adjust the quantity for this book to finish processing your cart."}
            return
          end
        }
        format.html { redirect_to root_url, notice: "Purchase successful." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    if !check_permissions?( "delete_cart")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:credit_card_number, :address, :phone_number, :user_id)
    end
end
