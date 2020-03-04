# frozen_string_literal: true

class Product < ApplicationRecord
  self.inheritance_column = nil

  VALID_TYPES = %w[Pizza Complement].freeze

  validates :name, :sku, :type, :price, presence: true
  validates :type, inclusion: { in: VALID_TYPES }
end
