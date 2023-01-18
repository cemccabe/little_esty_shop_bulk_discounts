require 'rails_helper'

RSpec.describe 'Bulk Discounts Edit Page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bd1 = @merchant1.bulk_discounts.create!(percentage: 50, quantity_threshold: 1)
    @bd2 = @merchant1.bulk_discounts.create!(percentage: 33.3, quantity_threshold: 5)
    @bd3 = @merchant2.bulk_discounts.create!(percentage: 10, quantity_threshold: 2)

    visit edit_merchant_bulk_discount_path(@merchant1, @bd1)
  end

  describe 'User Story #5' do
    it 'contains a prepopulated form to edit the discount' do
      expect(page).to have_field(:percentage, with: "#{@bd1.percentage}")
      expect(page).to have_field(:quantity_threshold, with: "#{@bd1.quantity_threshold}")
      expect(page).to have_button('Update Discount')

      fill_in :percentage, with: 25
      fill_in :quantity_threshold, with: 10

      click_button 'Update Discount'

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bd1))
      expect(page).to have_content("Percentage Discount: 25.0")
      expect(page).to have_content("Quantity Threshold: 10")
    end
  end
end