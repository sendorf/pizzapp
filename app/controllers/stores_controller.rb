# frozen_string_literal: true

class StoresController < ApplicationController
  def create
    @store = Store.new(store_params)
    if @store.save
      render json: @store, status: :ok
    else
      render json: @store.errors, status: :bad_request
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def update
    @store = Store.find(params[:id])
    Store.transaction do
      @store.products_stores.destroy_all
      if @store.update(store_params)
        render json: @store, status: :ok
      else
        render json: @store.errors, status: :bad_request
      end
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def destroy
    @store = Store.find(params[:id])
    if @store.destroy
      render json: @store, status: :ok
    else
      render json: @store.errors, status: :bad_request
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def show
    render json: Store.find(params[:id]), status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def index
    render json: Store.all, status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  private

  def allowed_store_params
    params.require(:store).permit(:name, :address, :email, :phone, products: %i[id quantity])
  end

  def products_stores
    @products_stores ||= allowed_store_params[:products].map do |product|
      ProductsStore.new(product_id: product[:id], quantity: product[:quantity])
    end
  end

  def store_params
    { name: allowed_store_params[:name],
      address: allowed_store_params[:address],
      email: allowed_store_params[:email],
      phone: allowed_store_params[:phone],
      products_stores: products_stores }
  end
end
