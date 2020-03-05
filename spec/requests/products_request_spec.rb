# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:product) { Product.new(name: name, sku: sku, price: price, type: type) }
  let(:product_id) { 'hneknfdnks' }
  let(:product_params) { { product: { name: name, sku: sku, price: price, type: type } } }
  let(:name) { 'product name' }
  let(:sku) { 'foo sku' }
  let(:price) { 12 }
  let(:type) { 'Pizza' }
  let(:error_message) { 'foo error message' }

  describe 'request list of all products' do
    context 'when there are no products' do
      it 'returns an empty collection' do
        get products_path
        expect(response).to be_successful
        expect(response.body).to eq [].to_json
      end
    end

    context 'when there are products' do
      it 'returns the products collection' do
        expect(Product).to receive(:all).and_return [product]
        get products_path
        expect(response).to be_successful
        expect(response.body).to include(name)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Product).to receive(:all).and_raise StandardError.new(error_message)
        get products_path
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request a product' do
    context 'when there is no product' do
      it 'returns an empty collection' do
        get product_path(product_id)
        expect(response).not_to be_successful
        expect(response.body).to include("Couldn't find Product with 'id'=#{product_id}")
      end
    end

    context 'when there is a product' do
      it 'returns the product' do
        expect(Product).to receive(:find).with(product_id).and_return product
        get product_path(product_id)
        expect(response).to be_successful
        expect(response.body).to include('product name')
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Product).to receive(:find).with(product_id).and_raise StandardError.new(error_message)
        get product_path(product_id)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request creating a product' do
    context 'when the request is correct' do
      it 'returns the product' do
        expect(Product).to receive(:new).and_return product
        expect(product).to receive(:save).and_return true
        post products_path(product_params)
        expect(response).to be_successful
        expect(response.body).to include(name)
        expect(response.body).to include(type)
        expect(response.body).to include(sku)
        expect(response.body).to include(price.to_s)
      end
    end

    context 'when the request is not correct' do
      it 'returns a 400 error' do
        expect(Product).to receive(:new).and_return product
        expect(product).to receive(:save).and_return false
        expect(product).to receive(:errors).and_return error_message
        post products_path(product_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '400'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Product).to receive(:new).and_raise StandardError.new(error_message)
        post products_path(product_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request updating a product' do
    context 'when the request is correct' do
      it 'returns the product' do
        expect(Product).to receive(:find).with(product_id).and_return product
        expect(product).to receive(:update).and_return true
        put product_path(product_id, product_params)
        expect(response).to be_successful
        expect(response.body).to include(name)
        expect(response.body).to include(type)
        expect(response.body).to include(sku)
        expect(response.body).to include(price.to_s)
      end
    end

    context 'when the request is not correct' do
      it 'returns a 400 error' do
        expect(Product).to receive(:find).with(product_id).and_return product
        expect(product).to receive(:update).and_return false
        expect(product).to receive(:errors).and_return error_message
        put product_path(product_id, product_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '400'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Product).to receive(:find).with(product_id).and_raise StandardError.new(error_message)
        put product_path(product_id, product_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is no product' do
      it 'returns an empty collection' do
        put product_path(product_id, product_params)
        expect(response).not_to be_successful
        expect(response.body).to include("Couldn't find Product with 'id'=#{product_id}")
      end
    end
  end
end
