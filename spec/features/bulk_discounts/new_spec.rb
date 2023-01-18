require 'rails_helper'

RSpec.describe 'Bulk Discounts New Page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    visit new_merchant_bulk_discount_path(@merchant1)
  end

  describe 'User Story #2' do
    it 'fills in the form with valid data and is redirected back to the bulk discount index' do
      within("#new_discount_form") do
        fill_in :percentage, with: 15
        fill_in :quantity_threshold, with: 5
        click_button 'Create Bulk Discount'
      end
      
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to have_content('Percentage: 15.0')
      expect(page).to have_content('Quantity Threshold: 5')
    end
  end
end