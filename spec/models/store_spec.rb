# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'relations' do
    it { is_expected.to have_many :orders }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :phone }
  end
end
