# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsStore, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :store }
    it { is_expected.to belong_to :product }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :quantity }
  end
end
