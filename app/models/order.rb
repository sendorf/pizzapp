# frozen_string_literal: true

class Order < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :store
  has_and_belongs_to_many :products

  validates :total, presence: true
end
