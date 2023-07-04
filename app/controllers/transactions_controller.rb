
class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    unless check_permissions?("view_transaction")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    # ensures users can only see their own transactions and not other users' transactions
    if current_user
      @transactions = Transaction.where(user_id: current_user.id)
    else
      @transactions = Transaction.all
    end
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    # can only perform this action if permission is provided & if record belongs to user
    if !check_permissions?("show_transaction") ||
      (check_permissions?("show_transaction") && !current_user.nil? && current_user.id != @transaction.user_id)
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
  end

  # GET /transactions/new
  def new
    unless check_permissions?("create_transaction")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @transaction = Transaction.new
    # Auto-fill book
    if @book.nil? && params[:book_id]
      @book = Book.find(params[:book_id])
    end
  end

  # GET /transactions/1/edit
  def edit
    unless check_permissions?("edit_transaction")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
  end

  # POST /transactions or /transactions.json
  def create
    unless check_permissions?("create_transaction")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    @transaction = Transaction.new(transaction_params)

    # Creates transaction number using a random 10-digit number
    @transaction.transaction_number = Array.new(10){[*"0".."9"].sample}.join

    # Link the transaction to the book chosen by user
    @book = Book.find(params[:transaction][:book_id])

    # Link the transaction to the current user
    @transaction.user = current_user

    # Before creating transaction, checks to see if book stock is still available from when user landed on new transaction page
    @book.with_lock do
      if (@book.stock - @transaction.quantity.to_i) < 0
        redirect_to books_path, flash: {notice: "This book is no longer available for purchase. We could not complete this order."}
        return
      end
    end

    respond_to do |format|
      #update available stock of book if transaction quantity requested is available
      if @transaction.save && (@book.stock - @transaction.quantity.to_i) >= 0
        @book.with_lock do
          @book.stock = @book.stock - @transaction.quantity.to_i
          @book.save
        end
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    unless check_permissions?("update_transaction")
      redirect_to root_path, flash: { notice: "Permission Denied" }
    end
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    if !check_permissions?( "delete_transaction")
      redirect_to root_path, flash: {notice: "Permission Denied"}
    end
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:book_id, :user_id, :credit_card_number, :address, :phone_number, :quantity, :total_price)
  end
end