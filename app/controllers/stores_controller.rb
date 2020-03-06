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
    if @store.update(store_params)
      render json: @store, status: :ok
    else
      render json: @store.errors, status: :bad_request
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

  def store_params
    params.require(:store).permit(:name, :address, :email, :phone)
  end
end
