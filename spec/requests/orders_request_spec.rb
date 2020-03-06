# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:order) { Order.new(store_id: store_id, orders_products: [orders_product], total: total) }
  let(:store_id) { 'sarodasa' }
  let(:orders_product) { OrdersProduct.new(product: product, quantity: quantity) }
  let(:order_id) { 'hneknfdnks' }
  let(:quantity) { 5 }
  let(:total) { 21_321 }
  let(:order_params) { { order: { name: store_id, products: [{ id: product_id, quantity: quantity }] } } }
  let(:product) { Product.new(id: product_id, name: name, sku: sku, price: price, type: type) }
  let(:product_id) { 'ewrewrw' }
  let(:product_params) { { product: { name: name, sku: sku, price: price, type: type } } }
  let(:name) { 'product name' }
  let(:sku) { 'foo sku' }
  let(:price) { 12 }
  let(:type) { 'Pizza' }
  let(:error_message) { 'foo error message' }

  describe 'request list of all orders' do
    context 'when there are no orders' do
      it 'returns an empty collection' do
        get orders_path
        expect(response).to be_successful
        expect(response.body).to eq [].to_json
      end
    end

    context 'when there are orders' do
      it 'returns the orders collection' do
        expect(Order).to receive(:all).and_return [order]
        get orders_path
        expect(response).to be_successful
        expect(response.body).to include(quantity.to_s)
        expect(response.body).to include(total.to_s)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Order).to receive(:all).and_raise StandardError.new(error_message)
        get orders_path
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request a order' do
    context 'when there is no order' do
      it 'returns an empty collection' do
        get order_path(order_id)
        expect(response).not_to be_successful
        expect(response.body).to include("Couldn't find Order with 'id'=#{order_id}")
      end
    end

    context 'when there is a order' do
      it 'returns the order' do
        expect(Order).to receive(:find).with(order_id).and_return order
        get order_path(order_id)
        expect(response).to be_successful
        expect(response.body).to include(quantity.to_s)
        expect(response.body).to include(total.to_s)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Order).to receive(:find).with(order_id).and_raise StandardError.new(error_message)
        get order_path(order_id)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request creating a order' do
    context 'when the request is correct' do
      it 'returns the order' do
        expect(Order).to receive(:new).and_return order
        expect(order).to receive(:save).and_return true
        post orders_path(order_params)
        expect(response).to be_successful
        expect(response.body).to include(quantity.to_s)
        expect(response.body).to include(total.to_s)
      end
    end

    context 'when the request is not correct' do
      it 'returns a 400 error' do
        expect(Order).to receive(:new).and_return order
        expect(order).to receive(:save).and_return false
        expect(order).to receive(:errors).and_return error_message
        post orders_path(order_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '400'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Order).to receive(:new).and_raise StandardError.new(error_message)
        post orders_path(order_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request updating a order' do
    context 'when the request is correct' do
      it 'returns the order' do
        expect(Order).to receive(:find).with(order_id).and_return order
        expect(order).to receive(:update).and_return true
        put order_path(order_id, order_params)
        expect(response).to be_successful
        expect(response.body).to include(total.to_s)
      end
    end

    context 'when the request is not correct' do
      it 'returns a 400 error' do
        expect(Order).to receive(:find).with(order_id).and_return order
        expect(order).to receive(:update).and_return false
        expect(order).to receive(:errors).and_return error_message
        put order_path(order_id, order_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '400'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Order).to receive(:find).with(order_id).and_raise StandardError.new(error_message)
        put order_path(order_id, order_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is no order' do
      it 'returns an empty collection' do
        put order_path(order_id, order_params)
        expect(response).not_to be_successful
        expect(response.body).to include("Couldn't find Order with 'id'=#{order_id}")
      end
    end
  end
end
