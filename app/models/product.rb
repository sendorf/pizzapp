# frozen_string_literal: true

class Product < ApplicationRecord
  self.inheritance_column = nil
  self.implicit_order_column = 'created_at'

  VALID_TYPES = %w[Pizza Complement].freeze

  validates :name, :sku, :type, :price, presence: true
  validates :type, inclusion: { in: VALID_TYPES }
end
