# frozen_string_literal: true

class Order < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :store
  has_many :products, through: :orders_products
  has_many :orders_products

  validates :total, presence: true
end
