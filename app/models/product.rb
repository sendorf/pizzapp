# frozen_string_literal: true

class Product < ApplicationRecord
  self.inheritance_column = nil
  self.implicit_order_column = 'created_at'

  has_many :orders, through: :orders_products
  has_many :stores, through: :products_stores
  has_many :orders_products
  has_many :products_stores

  VALID_TYPES = %w[Pizza Complement].freeze

  validates :name, :sku, :type, :price, presence: true
  validates :type, inclusion: { in: VALID_TYPES }
end
