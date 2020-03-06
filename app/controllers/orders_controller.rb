# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :bad_request
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def update
    @order = Order.find(params[:id])
    Order.transaction do
      @order.orders_products.destroy_all
      if @order.update(order_params)
        render json: @order, status: :ok
      else
        render json: @order.errors, status: :bad_request
      end
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def show
    render json: Order.find(params[:id]), status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def index
    render json: Order.all, status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  private

  def allowed_order_params
    params.require(:order).permit(:store_id, products: %i[id quantity])
  end

  def orders_products
    @orders_products ||= allowed_order_params[:products].map do |product|
      OrdersProduct.new(product_id: product[:id], quantity: product[:quantity])
    end
  end

  def order_params
    { store_id: allowed_order_params[:store_id], orders_products: orders_products }
  end
end
