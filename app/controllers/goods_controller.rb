class GoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_good, only: [:edit, :show, :update, :destroy]
  def index
    @goods = Good.includes(:user).order('created_at DESC')
  end

  def new
    @good = Good.new
  end

  def show
  end

  def update
    if @good.update(good_params)
      redirect_to good_path
    else
      render :edit
    end
  end

  def edit
  end

  def create
    @good = Good.new(good_params)
    if @good.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @good.user.id
    @good.destroy
    redirect_to root_path
    end
  end

  private

  def good_params
    params.require(:good).permit(:shop_name, :description, :price, :image, :category_id, :condition_id, :shipping_expense_id, :prefecture_id, :scheduled_delivery_id).merge(user_id: current_user.id)
  end

  def find_good
    @good = Good.find(params[:id])
  end
end
