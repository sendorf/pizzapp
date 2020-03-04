# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Complement, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :sku }
    it { is_expected.to validate_presence_of :price }
  end
end
