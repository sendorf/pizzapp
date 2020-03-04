# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, :address, :email, :phone, presence: true
end
