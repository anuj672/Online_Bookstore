class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_admin
  before_action :authorized
  helper_method :logged_in?
  helper_method :check_permissions?
  helper_method :current_cart

  before_action :current_cart

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    redirect_to root_path, flash: { notice: "No record exists" }
  end

  # sets current_user if user
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  # sets/creates current_cart if user
  def current_cart
    if !current_user.nil?
      if !current_user.cart.nil?
        @cart = Cart.find(current_user.cart.id)
        session[:cart] = @cart.id
      else
        @cart = Cart.create(:user_id => current_user.id, :address => current_user.address,
                                    :phone_number => current_user.phone_number,
                                    :credit_card_number => current_user.credit_card_number)
        session[:cart] = @cart.id
        redirect_to root_url, notice: "Logged in!"
      end
    end
  end

  # sets current_admin if admin
  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find(session[:admin_id])
    else
      @current_admin = nil
    end
  end

  def logged_in?
    !current_user.nil? || !current_admin.nil?
  end

  def authorized
    redirect_to root_path unless logged_in?
  end

  # checks permissions before each action
  def check_permissions?(action)
    if current_admin
      @actions = ['view_admin',
                  'show_admin',
                  'edit_admin',
                  'update_admin',
                  'view_user',
                  'show_user',
                  'delete_user',
                  'edit_user',
                  'update_user',
                  'create_user',
                  'create_cart',
                  'view_book',
                  'edit_book',
                  'delete_book',
                  'create_book',
                  'update_book',
                  'show_book',
                  'view_review',
                  'show_review',
                  'edit_review',
                  'create_review',
                  'update_review',
                  'delete_review'
      ]

    elsif current_user
      @actions = ['show_user',
                  'delete_user',
                  'edit_user',
                  'update_user',
                  'view_cart',
                  'edit_cart',
                  'update_cart',
                  'show_cart',
                  'create_cart_item',
                  'edit_cart_item',
                  'delete_cart_item',
                  'update_cart_item',
                  'show_cart_item',
                  'view_cart_item',
                  'view_book',
                  'show_book',
                  'view_review',
                  'edit_review',
                  'show_review',
                  'create_review',
                  'update_review',
                  'create_transaction',
                  'view_transaction',
                  'show_transaction',
                  ]
    end
    if (current_admin || current_user) && @actions.include?(action)
      return true
    else
      return false
    end
    end
end
