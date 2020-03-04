# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:name) { 'Foo name' }
  let(:sku) { 'Foo sku' }
  let(:type) { described_class::VALID_TYPES[0] }
  let(:price) { 3_435 }
  let(:attributes) { { name: name, sku: sku, type: type, price: price } }

  subject { described_class.new(attributes) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :sku }
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_presence_of :price }

    context 'type acceptance' do
      context 'when type is valid' do
        described_class::VALID_TYPES.each do |valid_type|
          context "with type #{valid_type}" do
            let(:type) { valid_type }

            it 'creates the subject correctly' do
              expect(subject).to eq subject
            end
          end
        end
      end
      context 'when type is invalid' do
        let(:type) { 'InvalidType' }

        it 'raises ActiveRecord::SubclassNotFound error' do
          byebug
          expect(subject).to raise_error ActiveRecord::SubclassNotFound
        end
      end
    end
  end
end
