# frozen_string_literal: true

class OrdersProduct < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
end
