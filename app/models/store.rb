# frozen_string_literal: true

class Store < ApplicationRecord
  self.implicit_order_column = 'created_at'

  has_many :orders
  has_many :products_stores
  has_many :products, through: :products_stores

  validates :name, :address, :phone, presence: true
end
