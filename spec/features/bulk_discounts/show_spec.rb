require 'rails_helper'

RSpec.describe 'Bulk Discounts Show Page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bd1 = @merchant1.bulk_discounts.create!(percentage: 50, quantity_threshold: 1)
    @bd2 = @merchant1.bulk_discounts.create!(percentage: 33.3, quantity_threshold: 5)
    @bd3 = @merchant2.bulk_discounts.create!(percentage: 10, quantity_threshold: 2)

    visit merchant_bulk_discount_path(@merchant1, @bd1)
  end

  describe 'User Story #4' do
    it 'display\'s the bulk discount\'s quantity threshold and percentage discount' do
      expect(page).to have_content("Bulk Discount #{@bd1.id}")
      expect(page).to have_content("Percentage Discount: #{@bd1.percentage}")
      expect(page).to have_content("Quantity Threshold: #{@bd1.quantity_threshold}")
      
      expect(page).to_not have_content("Bulk Discount #{@bd2.id}")
      expect(page).to_not have_content("Percentage Discount: #{@bd2.percentage}")
      expect(page).to_not have_content("Quantity Threshold: #{@bd2.quantity_threshold}")
      
      expect(page).to_not have_content("Bulk Discount #{@bd3.id}")
      expect(page).to_not have_content("Percentage Discount: #{@bd3.percentage}")
      expect(page).to_not have_content("Quantity Threshold: #{@bd3.quantity_threshold}")
    end
  end

  describe 'User Story #5' do
    it 'contains a link to edit a bulk discount' do
      expect(page).to have_link('Edit Bulk Discount')
      click_link 'Edit Bulk Discount'
      expect(page).to have_current_path(edit_merchant_bulk_discount_path(@merchant1, @bd1))
    end
  end
end