# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stores', type: :request do
  let(:store) { Store.new(name: name, address: address, email: email, phone: phone) }
  let(:store_id) { 'hneknfdnks' }
  let(:store_params) { { store: { ame: name, address: address, email: email, phone: phone } } }
  let(:name) { 'store name' }
  let(:address) { 'foo street' }
  let(:email) { 'fake@foo.com' }
  let(:phone) { '4567898765' }
  let(:error_message) { 'foo error message' }

  describe 'request list of all stores' do
    context 'when there are no stores' do
      it 'returns an empty collection' do
        get stores_path
        expect(response).to be_successful
        expect(response.body).to eq [].to_json
      end
    end

    context 'when there are stores' do
      it 'returns the stores collection' do
        expect(Store).to receive(:all).and_return [store]
        get stores_path
        expect(response).to be_successful
        expect(response.body).to include(name)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Store).to receive(:all).and_raise StandardError.new(error_message)
        get stores_path
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request a store' do
    context 'when there is no store' do
      it 'returns an empty collection' do
        get store_path(store_id)
        expect(response).not_to be_successful
        expect(response.body).to include("Couldn't find Store with 'id'=#{store_id}")
      end
    end

    context 'when there is a store' do
      it 'returns the store' do
        expect(Store).to receive(:find).with(store_id).and_return store
        get store_path(store_id)
        expect(response).to be_successful
        expect(response.body).to include(name)
        expect(response.body).to include(address)
        expect(response.body).to include(email)
        expect(response.body).to include(phone)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Store).to receive(:find).with(store_id).and_raise StandardError.new(error_message)
        get store_path(store_id)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request creating a store' do
    context 'when the request is correct' do
      it 'returns the store' do
        expect(Store).to receive(:new).and_return store
        expect(store).to receive(:save).and_return true
        post stores_path(store_params)
        expect(response).to be_successful
        expect(response.body).to include(name)
        expect(response.body).to include(address)
        expect(response.body).to include(email)
        expect(response.body).to include(phone)
      end
    end

    context 'when the request is not correct' do
      it 'returns a 400 error' do
        expect(Store).to receive(:new).and_return store
        expect(store).to receive(:save).and_return false
        expect(store).to receive(:errors).and_return error_message
        post stores_path(store_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '400'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Store).to receive(:new).and_raise StandardError.new(error_message)
        post stores_path(store_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end
  end

  describe 'request updating a store' do
    context 'when the request is correct' do
      it 'returns the store' do
        expect(Store).to receive(:find).with(store_id).and_return store
        expect(store).to receive(:update).and_return true
        put store_path(store_id, store_params)
        expect(response).to be_successful
        expect(response.body).to include(name)
        expect(response.body).to include(address)
        expect(response.body).to include(email)
        expect(response.body).to include(phone)
      end
    end

    context 'when the request is not correct' do
      it 'returns a 400 error' do
        expect(Store).to receive(:find).with(store_id).and_return store
        expect(store).to receive(:update).and_return false
        expect(store).to receive(:errors).and_return error_message
        put store_path(store_id, store_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '400'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is an exception' do
      it 'returns a 422 error' do
        expect(Store).to receive(:find).with(store_id).and_raise StandardError.new(error_message)
        put store_path(store_id, store_params)
        expect(response).not_to be_successful
        expect(response.code).to eq '422'
        expect(response.body).to include(error_message)
      end
    end

    context 'when there is no store' do
      it 'returns an empty collection' do
        put store_path(store_id, store_params)
        expect(response).not_to be_successful
        expect(response.body).to include("Couldn't find Store with 'id'=#{store_id}")
      end
    end
  end
end
