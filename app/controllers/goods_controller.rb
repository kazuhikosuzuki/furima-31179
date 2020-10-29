class GoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :edit, :show]
  def index
    @goods = Good.all.order("created_at DESC")
    @goods = Good.includes(:user)
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    if @good.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def good_params
    params.require(:good).permit(:shop_name, :description, :price, :image, :category_id, :condition_id, :shipping_expense_id, :prefecture_id, :scheduled_delivery_id).merge(user_id: current_user.id)
  end
end
