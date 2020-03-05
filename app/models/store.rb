# frozen_string_literal: true

class Store < ApplicationRecord
  self.implicit_order_column = 'created_at'

  has_many :orders

  validates :name, :address, :email, :phone, presence: true
end
