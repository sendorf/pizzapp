# frozen_string_literal: true

class ProductsStore < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :store
  belongs_to :product

  validates :quantity, presence: true
end
