require 'rails_helper'

RSpec.describe 'Bulk Discounts Index Page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bd1 = @merchant1.bulk_discounts.create!(percentage: 50, quantity_threshold: 1)
    @bd2 = @merchant1.bulk_discounts.create!(percentage: 33.3, quantity_threshold: 5)
    @bd3 = @merchant2.bulk_discounts.create!(percentage: 10, quantity_threshold: 2)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'User Story #1' do
    it 'displays all of the merchant\'s bulk discounts including their percentage and quantity threshold' do
      within("#bulk_discounts") do
        expect(page).to have_content("Percentage: #{@bd1.percentage}")
        expect(page).to have_content("Percentage: #{@bd2.percentage}")
        expect(page).to_not have_content("Percentage: #{@bd3.percentage}")

        expect(page).to have_content("Quantity Threshold: #{@bd1.quantity_threshold}")
        expect(page).to have_content("Quantity Threshold: #{@bd2.quantity_threshold}")
        expect(page).to_not have_content("Quantity Threshold: #{@bd3.quantity_threshold}")
      end
    end

    it 'And each bulk discount listed includes a link to its show page' do
      within("#bulk_discounts") do
        expect(page).to have_link("Bulk Discount #{@bd1.id}")
        expect(page).to have_link("Bulk Discount #{@bd2.id}")
        expect(page).to_not have_link("Bulk Discount #{@bd3.id}")

        click_link "Bulk Discount #{@bd1.id}"

        expect(page).to have_current_path("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}")
      end
    end
  end

  describe 'User Story #2' do
    it 'has a link to create a new discount that redirects to the create page' do
      within("#new_discount") do
        click_link 'Create a New Discount'
        expect(page).to have_current_path("/merchant/#{@merchant1.id}/bulk_discounts/new")
      end
    end
  end

  describe 'User Story #3' do
    it 'has a link to delete a bulk discount' do
      within("#bulk_discounts") do
        expect(page).to have_link("Delete Bulk Discount #{@bd1.id}")
        expect(page).to have_link("Delete Bulk Discount #{@bd2.id}")
        expect(page).to_not have_link("Delete Bulk Discount #{@bd3.id}")

        click_link "Delete Bulk Discount #{@bd1.id}"
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

      within("#bulk_discounts") do
        expect(page).to_not have_link("Delete Bulk Discount #{@bd1.id}")
        expect(page).to_not have_content("Percentage: #{@bd1.percentage}")
        expect(page).to_not have_content("Quantity Threshold: #{@bd1.quantity_threshold}")
        expect(page).to have_link("Delete Bulk Discount #{@bd2.id}")
        expect(page).to have_content("Percentage: #{@bd2.percentage}")
        expect(page).to have_content("Quantity Threshold: #{@bd2.quantity_threshold}")
      end
    end
  end

  describe 'User Story #9' do
    it 'displays the name and date of the next 3 upcoming US holidays under a header titled Upcoming Holidays' do
      within("#holidays") do
        expect(page).to have_content('Washington\'s Birthday')
        expect(page).to have_content('Good Friday')
        expect(page).to have_content('Memorial Day')

        expect(page).to have_content('2023-02-20')
        expect(page).to have_content('2023-04-07')
        expect(page).to have_content('2023-05-29')
      end
    end
  end
end