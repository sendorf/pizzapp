# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :products, :created_at, :updated_at

  def products
    object.orders_products.map do |orders_product|
      { id: orders_product.product_id, quantity: orders_product.quantity }
    end
  end
end
