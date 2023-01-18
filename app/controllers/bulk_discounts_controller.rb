class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show

  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create(bulk_discounts_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bd = BulkDiscount.find(params[:id])
    bd.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  private
  def bulk_discounts_params
    params.permit(:percentage, :quantity_threshold, :merchant_id)
  end
end