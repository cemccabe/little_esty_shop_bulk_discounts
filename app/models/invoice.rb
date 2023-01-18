class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discount
    invoice_items.joins(:bulk_discounts)
                 .where('bulk_discounts.quantity_threshold <= invoice_items.quantity')
                 .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage / 100)) AS total_discount')
                 .group('invoice_items.id')
                 .sum(&:total_discount)
  end

  def revenue_after_discount
    total_revenue - total_discount
  end
end
