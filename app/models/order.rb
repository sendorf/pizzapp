# frozen_string_literal: true

class Order < ApplicationRecord
  self.implicit_order_column = 'created_at'

  before_save :calculate_total

  belongs_to :store
  has_many :orders_products
  has_many :products, through: :orders_products

  private

  def calculate_total
    total = 0
    orders_products.each do |orders_product|
      total += (orders_product.product.price * orders_product.quantity)
    end
    self.total = total
  end
end
