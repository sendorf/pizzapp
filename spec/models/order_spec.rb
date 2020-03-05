# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :store }
    it { is_expected.to have_many :products }
    it { is_expected.to have_many :orders_products }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :total }
  end
end
