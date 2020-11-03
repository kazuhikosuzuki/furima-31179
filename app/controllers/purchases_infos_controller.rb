class PurchasesInfosController < ApplicationController
  before_action :authenticate_user!, only: [:new]


  def new
    @good = Good.find(params[:good_id])
    if current_user.id == @good.user_id || @good.purchase != nil
      redirect_to root_path
    end
    @purchase_adress = PurchaseAdress.new
  end

  def create
    @good = Good.find(params[:good_id])
    @purchase_adress = PurchaseAdress.new(purchases_info_params)
    if @purchase_adress.valid?
      @purchase_adress.save
      pay_item
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def purchases_info_params
    params.require(:purchase_adress).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, good_id: @good.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Good.find(params[:good_id]).price,
      card: purchases_info_params[:token],
      currency: 'jpy'
    )
  end

end
