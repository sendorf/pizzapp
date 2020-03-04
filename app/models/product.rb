# frozen_string_literal: true

class Product < ApplicationRecord
  VALID_TYPES = %w[Pizza Complement].freeze

  validates :name, :sku, :type, :price, presence: true
  validates :type, acceptance: { accept: VALID_TYPES }
end
