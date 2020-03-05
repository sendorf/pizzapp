# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersProduct, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :product }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :quantity }
  end
end
