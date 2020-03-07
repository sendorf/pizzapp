# frozen_string_literal: true

class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :email, :products, :created_at, :updated_at

  def products
    object.products_stores.map do |products_store|
      { id: products_store.product_id, quantity: products_store.quantity }
    end
  end
end
