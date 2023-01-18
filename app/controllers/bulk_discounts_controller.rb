class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holiday_names = HolidayService.holiday_name
    @holiday_dates = HolidayService.holiday_date
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create(bulk_discounts_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.update(bulk_discounts_params)
    redirect_to merchant_bulk_discount_path(merchant, discount)
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