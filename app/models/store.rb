class Store < ApplicationRecord
  validates :name, :address, :email, :phone, presence: true
end
