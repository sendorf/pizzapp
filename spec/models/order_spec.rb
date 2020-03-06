# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'callbacks' do
    it { is_expected.to callback(:calculate_total).before(:save) }
  end

  describe 'relations' do
    it { is_expected.to belong_to :store }
    it { is_expected.to have_many :products }
    it { is_expected.to have_many :orders_products }
  end
end
