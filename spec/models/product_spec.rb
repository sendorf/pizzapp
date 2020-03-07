# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'relations' do
    it { is_expected.to have_many :orders }
    it { is_expected.to have_many :orders_products }
    it { is_expected.to have_many :stores }
    it { is_expected.to have_many :products_stores }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :sku }
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_inclusion_of(:type).in_array(described_class::VALID_TYPES) }
  end
end
