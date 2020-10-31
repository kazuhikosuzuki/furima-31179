class PurchasesController < ApplicationController
  def index
    @good = Good.find(params[:good_id])
  end
end
