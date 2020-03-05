# frozen_string_literal: true

class ProductsController < ApplicationController
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :bad_request
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :bad_request
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def show
    render json: Product.find(params[:id]), status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def index
    render json: Product.all, status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku, :type, :price)
  end
end
