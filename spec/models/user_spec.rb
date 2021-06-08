# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:challenges) }
    it { is_expected.to have_many(:submissions).with_foreign_key('submitted_by_id') }
    it { is_expected.to have_many(:flagged_submissions).with_foreign_key('flagged_by_id') }
    it { is_expected.to have_many(:roles).through(:user_roles) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'custom validations' do
    let(:user) { create(:user, confirmed_at: DateTime.now) }

    it 'user name is valid' do
      expect(user.update(user_name: 'random_user1')).to be_truthy
    end

    it 'user name is not valid' do
      expect do
        user.update!(user_name: 'invalid user name')
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect do
        user.update!(user_name: 'invalid.user.name')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'password is valid' do
      expect(user.update(password: 'validpassword1')).to be_truthy
    end

    it 'password is not valid' do
      expect do
        user.update!(password: 'invalidpassword')
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect do
        user.update!(password: 'short1')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
